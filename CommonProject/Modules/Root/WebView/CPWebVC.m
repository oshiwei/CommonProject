//
//  CPWebVC.m
//  CommonProject
//
//  Created by wangzw on 2017/12/21.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "CPWebVC.h"
#import "UIWebView+TS_JavaScriptContext.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>

@interface CPWebVC () <NJKWebViewProgressDelegate, TSWebViewDelegate>
@property (nonatomic, strong) NJKWebViewProgress *progress;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) CPJSContext *jsContext;

@property (nonatomic, strong) UIBarButtonItem *customBackBarItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarItem;
@end

@implementation CPWebVC

- (instancetype)init {
    self = [super init];
    if (self) {
        _url = @"";
        _useWebTitle = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useCustomBackBarItem];
    self.customBackBarItem = self.navigationItem.leftBarButtonItem;
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@2);
    }];
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    //处理全屏播放视频，横屏返回时statubar的bug
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    if (!kIsNetwork) {
        [MBProgressHUD showOnlyTextToView:self.view title:@"网络异常"];
    }
}

- (BOOL)prefersStatusBarHidden {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

#pragma mark - back

- (void)customBackAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        //快速返回的时候，没有调用webViewDidFinishLoad，导致标题没有修改，延迟点，等返回操作完更新。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateNavigationItems];
            if (self.useWebTitle) {
                NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
                self.title = title;
            }
        });
    } else {
        [super customBackAction];
    }
}

- (void)closeBarItemAction {
    [super customBackAction];
}

- (void)updateNavigationItems {
    if (self.webView.canGoBack) {
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem, self.closeBarItem]];
    } else {
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}

#pragma mark - NJProgress delegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:NO];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [self updateNavigationItems];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    //禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [self updateNavigationItems];
    
    if (self.useWebTitle) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateNavigationItems];
}

#pragma mark - TSWebViewDelegate

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 打印异常
        ctx.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            DLog(@"%@", exceptionValue);
        };
        
        // 以 JSExport 协议关联 native 的方法
        ctx[@"CosBox"] = self.jsContext;
    });
}

#pragma mark - Notice

- (void)videoDidRotate {
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - setter

- (void)setUrl:(NSString *)url {
    _url = url?[url copy]:@"";
    if (_webView) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    }
}

#pragma mark - getter

- (CPJSContext *)jsContext {
    if (!_jsContext) {
        _jsContext = [[CPJSContext alloc] init];
        
        _jsContext.jumpTo = ^(NSString *url) {
            NSLog(@"jumpTo %@", url);
        };
    }
    return _jsContext;
}

- (NJKWebViewProgress *)progress {
    if (!_progress) {
        _progress = [[NJKWebViewProgress alloc] init];
        _progress.webViewProxyDelegate = self;
        _progress.progressDelegate = self;
    }
    return _progress;
}

- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectZero];
    }
    return _progressView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = CViewBgColor;
        _webView.scalesPageToFit = YES;
        _webView.opaque = NO;
        _webView.mediaPlaybackRequiresUserAction = NO;
        _webView.delegate = self.progress;
    }
    return _webView;
}

- (UIBarButtonItem *)closeBarItem {
    if (!_closeBarItem) {
        _closeBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_close"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(closeBarItemAction)];
        _closeBarItem.imageInsets = UIEdgeInsetsMake(0, -14, 0, 14);
    }
    return _closeBarItem;
}

@end

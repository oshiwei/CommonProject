//
//  RootViewController.m
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
- (void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle {
    _StatusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CViewBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //默认导航栏样式：黑字
    self.StatusBarStyle = UIStatusBarStyleDefault;
    
    //自定义返回按钮图片
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)dealloc {
    DLog(@"%@ is %s",NSStringFromClass([self class]),__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public

- (void)useCustomBackBarItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(customBackAction)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)customBackAction {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

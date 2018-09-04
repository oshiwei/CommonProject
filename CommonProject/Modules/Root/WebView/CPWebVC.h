//
//  CPWebVC.h
//  CommonProject
//
//  Created by wangzw on 2017/12/21.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "RootViewController.h"
#import "CPJSContext.h"

@interface CPWebVC : RootViewController

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, strong, readonly) CPJSContext *jsContext;
@property (nonatomic, assign) BOOL useWebTitle; //使用网页标题，默认YES

@end

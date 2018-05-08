//
//  AppDelegate+AppService.m
//  CommonProject
//
//  Created by wangzw on 2018/5/7.
//  Copyright © 2018年 wangzw. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "MainTabBarController.h"

@implementation AppDelegate (AppService)

#pragma mark ————— 初始化服务 —————

- (void)initService {
}

#pragma mark ————— 初始化window —————

- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if (@available(iOS 8.0, *)) {
        [[UIButton appearance] setExclusiveTouch:YES];  //避免多个按钮同时点击
    }
//    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark ————— 初始化TabBar —————

- (void)initTabBar {
    MainTabBarController *tabBar = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabBar;
}

#pragma mark ————— 程序启动完成 —————

- (void)appStarted {
}


@end

//
//  AppDelegate+AppService.h
//  CommonProject
//
//  Created by wangzw on 2018/5/7.
//  Copyright © 2018年 wangzw. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

/**
 初始化服务，执行需要在页面创建之前的操作，其他不紧急的放到页面创建之后的appStarted中
 */
- (void)initService;

//初始化window
- (void)initWindow;

//初始化TabBar
- (void)initTabBar;

//程序启动完成
- (void)appStarted;

@end

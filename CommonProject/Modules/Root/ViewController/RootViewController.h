//
//  RootViewController.h
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 VC 基类
 */
@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

/**
 使用自定返回按钮
 */
- (void)useCustomBackBarItem;

/**
 自定义返回事件
 */
- (void)customBackAction;

@end

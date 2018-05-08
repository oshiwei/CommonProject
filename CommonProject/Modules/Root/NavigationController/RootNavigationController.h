//
//  RootNavigationController.h
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 导航控制器基类
 */
@interface RootNavigationController : UINavigationController

/**
 返回到指定的类视图

 @param ClassName 类名
 @param animated 是否动画
 @return 是否成功
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end

//
//  RootNavigationController.m
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize {
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
//    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //去掉阴影线
//    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated {
    id vc = [self getCurrentViewControllerClass:ClassName];
    if (vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

/**
 获得当前导航器显示的视图

 @param ClassName 要获取的视图的名称
 @return 成功返回对应的对象，失败返回nil;
 */
- (instancetype)getCurrentViewControllerClass:(NSString *)ClassName {
    Class classObj = NSClassFromString(ClassName);
    NSArray *szArray =  self.viewControllers;
    for (id vc in szArray) {
        if ([vc isMemberOfClass:classObj]) {
            return vc;
        }
    }
    return nil;
}

#pragma mark - ——————— 屏幕旋转 ————————

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

//
//  MainTabBarController.m
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "MainTabBarController.h"
#import "RootNavigationController.h"
#import "UITabBar+CustomBadge.h"
#import "CPTabBar.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark ————— 初始化TabBar —————

- (void)setUpTabBar {
    //设置背景色 去掉分割线
    [self setValue:[CPTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor]];
    //通过这两个参数来调整badge位置
//    [self.tabBar setTabIconWidth:29];
//    [self.tabBar setBadgeTop:9];
}

#pragma mark - ——————— 初始化VC ————————

- (void)setUpAllChildViewController {
    _VCS = @[].mutableCopy;
    
    UIViewController *info = [UIViewController new];
    [self setupChildViewController:info
                             title:@"资讯"
                         imageName:@"tab_news_gray"
                   seleceImageName:@"tab_news_gold"];
    
    UIViewController *tv = [UIViewController new];
    [self setupChildViewController:tv
                             title:@"英魂TV"
                         imageName:@"tab_tv_gray"
                   seleceImageName:@"tab_tv_gold"];
    
    UIViewController *match = [UIViewController new];
    [self setupChildViewController:match
                             title:@"全民赛事"
                         imageName:@"tab_match_gray"
                   seleceImageName:@"tab_match_gold"];
    
    UIViewController *post = [UIViewController new];
    [self setupChildViewController:post
                             title:@"社区"
                         imageName:@"tab_community_gray"
                   seleceImageName:@"tab_community_gold"];
    
    UIViewController *role = [UIViewController new];
    [self setupChildViewController:role
                             title:@"我"
                         imageName:@"tab_me_gray"
                   seleceImageName:@"tab_me_gold"];
    
    self.viewControllers = _VCS;
}

- (void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CFontColor2,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgFontColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:controller];
    
    [_VCS addObject:nav];
}

#pragma mark - ——————— UITabBarControllerDelegate ————————

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSLog(@"选中 %ld",tabBarController.selectedIndex);
}

#pragma mark - ——————— action&method ————————

- (void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow {
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    } else {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
}

#pragma mark - ——————— 屏幕旋转 ————————

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

//
//  FontAndColorMacros.h
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f


#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor  UIColorHex(0xffffff)
#define CNavBgFontColor  UIColorHex(0xc88c64)

//默认页面背景色
#define CViewBgColor UIColorHex(0xffffff)

//设置页面背景颜色
#define CSettingViewBgColor UIColorHex(0xf0f4f7)

//分割线颜色
#define CLineColor UIColorHex(0xd0d0d0)

//字色
#define CFontColor1 UIColorHex(0x333333)

//次级字色
#define CFontColor2 UIColorHex(0x999999)

//按钮正常颜色
#define CButtonBgColor1 UIColorHex(0xdcaa64)

//按钮灰态颜色
#define CButtonBgColor2 UIColorHex(0xd0d0d0)

//测试用随机色
#define HBRandomColor [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1]


#pragma mark -  字体区

//资讯列表cell标题字体
#define FINFOLISTCELLTITLE [UIFont boldSystemFontOfSize:kRealValue(14)]

#define FFont1 [UIFont systemFontOfSize:12.0f]

#endif /* FontAndColorMacros_h */

//
//  URLMacros.h
//  CommonProject
//
//  Created by wangzw on 2017/11/28.
//  Copyright © 2017年 nd. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h

/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#ifdef COMMONPROJECTDEV
//开发版本环境配置
#define DevelopSever    1
#define TestSever       0
#define ProductSever    0
////////////////////////////
#else
//正式版本环境配置，最好不改动，避免发布出错
#define DevelopSever    0
#define TestSever       0
#define ProductSever    1
////////////////////////////
#endif

/* ****************************************
 * 开发环境服务器
 *****************************************/
#if DevelopSever

/**开发服务器*/
#define URL_main @"http://192.168.244.65:5000/api/graphql"

/* ****************************************
 * 测试环境服务器
 *****************************************/
#elif TestSever

/**测试服务器*/
#define URL_main @"http://192.168.244.65:5000/api/graphql"

/* ****************************************
 * 生产环境服务器
 *****************************************/
#elif ProductSever

/**生产服务器*/
#define URL_main @"https://yhzs.99.com/api/graphql"

#endif

/**没有分环境的写在下面*/

//周免英雄js
#define URL_weekFreeHero @"https://yhkd.99.com/script/data/hero/v1/syzh/zhoumian.js"

#endif /* URLMacros_h */

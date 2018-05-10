//
//  CPNetworkHelper.h
//  CommonProject
//
//  Created by wangzw on 2017/11/29.
//  Copyright © 2017年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "CPNetworkCache.h"

#ifndef kIsNetwork
#define kIsNetwork     [CPNetworkHelper isNetwork]  // 一次性判断是否有网的宏
#endif

#ifndef kIsWWANNetwork
#define kIsWWANNetwork [CPNetworkHelper isWWANNetwork]  // 一次性判断是否为手机网络的宏
#endif

#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork [CPNetworkHelper isWiFiNetwork]  // 一次性判断是否为WiFi网络的宏
#endif

typedef NS_ENUM(NSUInteger, HBRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    HBRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    HBRequestSerializerHTTP,
};

@interface CPNetworkHelper : NSObject

/**
 有网YES, 无网:NO
 */
+ (BOOL)isNetwork;

/**
 手机网络:YES, 反之:NO
 */
+ (BOOL)isWWANNetwork;

/**
 WiFi网络:YES, 反之:NO
 */
+ (BOOL)isWiFiNetwork;


+ (nullable NSURLSessionTask *)GET:(nonnull NSString *)URL
                        parameters:(nullable id)parameters
                        modelClass:(nullable Class)modelClass
                     responseCache:(nullable void (^)(id _Nullable))responseCache
                           success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                           failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;


+ (nullable NSURLSessionTask *)POST:(nonnull NSString *)URL
                         parameters:(nullable id)parameters
                         modelClass:(nullable Class)modelClass
                      responseCache:(nullable void (^)(id _Nullable))responseCache
                            success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (nullable NSURLSessionTask *)EncodePOST:(nonnull NSString *)URL
                               parameters:(nullable id)parameters
                               modelClass:(nullable Class)modelClass
                        responseCache:(nullable void (^)(id _Nullable))responseCache
                                  success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (nullable NSURLSessionDownloadTask *)downloadTaskWithRequest:(nonnull NSURLRequest *)request
                                                      progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgressBlock
                                                   destination:(nullable NSURL * _Nullable (^)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response))destination
                                             completionHandler:(nullable void (^)(NSURLResponse * _Nullable response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark - 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer HBRequestSerializerJSON(JSON格式),HBRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(HBRequestSerializer)requestSerializer;

@end

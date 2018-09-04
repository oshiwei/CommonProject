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

NS_ASSUME_NONNULL_BEGIN

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


+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
               modelClass:(Class)modelClass
            responseCache:(void (^)(id responseCache))responseCache
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                modelClass:(Class)modelClass
             responseCache:(void (^)(id responseCache))responseCache
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionTask *)EncodePOST:(NSString *)URL
                      parameters:(id)parameters
                      modelClass:(Class)modelClass
                   responseCache:(void (^)(id responseCache))responseCache
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark - 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer HBRequestSerializerJSON(JSON格式),HBRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(HBRequestSerializer)requestSerializer;

@end

NS_ASSUME_NONNULL_END

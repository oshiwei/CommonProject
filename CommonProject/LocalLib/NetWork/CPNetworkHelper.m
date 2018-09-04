//
//  CPNetworkHelper.m
//  CommonProject
//
//  Created by wangzw on 2017/11/29.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "CPNetworkHelper.h"

static AFHTTPSessionManager *_sessionManager;

@implementation CPNetworkHelper

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 网络状态

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

#pragma mark - GET请求

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
               modelClass:(Class)modelClass
            responseCache:(void (^)(id responseCache))responseCache
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //读取缓存
    responseCache != nil ? responseCache([CPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress *uploadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        id backObject = responseObject;
        if (modelClass && responseObject) {
            backObject = [modelClass modelWithJSON:responseObject];
        }
        success ? success(task, backObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [CPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure ? failure(task, error) : nil;
    }];
    return sessionTask;
}

#pragma mark - POST请求
+ (NSURLSessionTask *)POST:(NSString *)URL
         requestSerializer:(HBRequestSerializer)requestSerializer
                parameters:(id)parameters
                modelClass:(Class)modelClass
             responseCache:(void (^)(id responseCache))responseCache
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //读取缓存
    responseCache != nil ? responseCache([CPNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    [self setRequestSerializer:requestSerializer];
    NSURLSessionTask *sessionTask = nil;
    sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress *uploadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        id backObject = responseObject;
        if (modelClass && responseObject) {
            backObject = [modelClass modelWithJSON:responseObject];
        }
        success ? success(task, backObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [CPNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure ? failure(task, error) : nil;
    }];
    return sessionTask;
}

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                modelClass:(Class)modelClass
             responseCache:(void (^)(id responseCache))responseCache
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self POST:URL requestSerializer:HBRequestSerializerJSON parameters:parameters modelClass:modelClass responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionTask *)EncodePOST:(NSString *)URL
                      parameters:(id)parameters
                      modelClass:(Class)modelClass
                   responseCache:(void (^)(id responseCache))responseCache
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self POST:URL requestSerializer:HBRequestSerializerHTTP parameters:parameters modelClass:modelClass responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
    //开始下载
    [downloadTask resume];
    return downloadTask;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setRequestSerializer:(HBRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==HBRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

@end

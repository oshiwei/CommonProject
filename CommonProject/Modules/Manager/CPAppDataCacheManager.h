//
//  CPAppDataCacheManager.h
//  CommonProject
//
//  Created by wangzw on 2017/12/1.
//  Copyright © 2017年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPAppDataCacheManager : NSObject

SINGLETON_FOR_HEADER(CPAppDataCacheManager)

//Integer
- (void)setInteger:(NSInteger)value forKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;

//BOOL
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;

/**
 方法说明查看YYCache
 */
- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;
- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;
- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;
- (void)removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end;

@end

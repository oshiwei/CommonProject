//
//  CPAppDataCacheManager.m
//  CommonProject
//
//  Created by wangzw on 2017/12/1.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "CPAppDataCacheManager.h"

@interface CPAppDataCacheManager ()

@property (nonatomic, strong) YYCache *appDataCache;

@end

@implementation CPAppDataCacheManager

SINGLETON_FOR_CLASS(CPAppDataCacheManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *cacheFolder = [[UIApplication sharedApplication] documentsPath];
        NSString *path = [cacheFolder stringByAppendingPathComponent:@"CPAppDataCache"];
        _appDataCache = [YYCache cacheWithPath:path];
    }
    return self;
}

#pragma mark - public

- (void)setInteger:(NSInteger)value forKey:(NSString *)key {
    [self setObject:@(value) forKey:key];
}

- (NSInteger)integerForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self objectForKey:key];
    if (number && [number isKindOfClass:[NSNumber class]]) {
        return [number integerValue];
    }
    return 0;
}

- (void)setBool:(BOOL)value forKey:(NSString *)key {
    [self setObject:@(value) forKey:key];
}

- (BOOL)boolForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self objectForKey:key];
    if (number && [number isKindOfClass:[NSNumber class]]) {
        return ([number integerValue] != 0);
    }
    return NO;
}

#pragma mark - YYCache Method
- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.appDataCache containsObjectForKey:key];
}
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block {
    [self.appDataCache containsObjectForKey:key withBlock:block];
}
- (id<NSCoding>)objectForKey:(NSString *)key {
    return [self.appDataCache objectForKey:key];
}
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block {
    [self.appDataCache objectForKey:key withBlock:block];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [self.appDataCache setObject:object forKey:key];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block {
    [self.appDataCache setObject:object forKey:key withBlock:block];
}
- (void)removeObjectForKey:(NSString *)key {
    [self.appDataCache removeObjectForKey:key];
}
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block {
    [self.appDataCache removeObjectForKey:key withBlock:block];
}
- (void)removeAllObjects {
    [self.appDataCache removeAllObjects];
}
- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [self.appDataCache removeAllObjectsWithBlock:block];
}
- (void)removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end {
    [self.appDataCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

@end

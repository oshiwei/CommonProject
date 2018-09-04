//
//  CPJSContext.h
//  CommonProject
//
//  Created by wangzw on 2017/12/21.
//  Copyright © 2017年 nd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol CPJSContextProtocol <JSExport>
/*
 * token
 */
- (NSString *)getSessionId;
/*
 * uid
 */
- (NSString *)getUid;
/*
 * uuid
 */
- (NSString *)getUniqueId;
/*
 * 链接跳转
 */
- (void)jump:(NSString *)url;

@end

@interface CPJSContext : NSObject <CPJSContextProtocol>

@property (nonatomic, copy) void (^jumpTo)(NSString *url);

@end

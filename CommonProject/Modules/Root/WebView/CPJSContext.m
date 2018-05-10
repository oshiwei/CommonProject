//
//  CPJSContext.m
//  CommonProject
//
//  Created by wangzw on 2017/12/21.
//  Copyright © 2017年 nd. All rights reserved.
//

#import "CPJSContext.h"

@implementation CPJSContext

- (NSString *)getSessionId {
    return @"";
}

- (NSString *)getUid {
    return @"";
}

- (NSString *)getUniqueId {
    return @"";
}

- (void)jump:(NSString *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.jumpTo?self.jumpTo(url):nil;
    });
}

@end

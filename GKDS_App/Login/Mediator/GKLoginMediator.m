//
//  GKLoginMediator.m
//  GKDS_App
//
//  Created by wang on 16/3/23.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKLoginMediator.h"

@implementation GKLoginMediator

- (void)handleNotification:(id<INotification>)notification {
    
    if ([notification.name isEqualToString:kUserLoginWithQQ]) {
        NSLog(@"用户第三方QQ登录");
        return;
    }
    
    if ([notification.name isEqualToString:kUserLoginWithSina]) {
        NSLog(@"用户第三方新浪微博登录");
        return;
    }
    
    if ([notification.name isEqualToString:kUserLoginWithWeiXin]) {
        NSLog(@"用户第三方微信登录");
        return;
    }
    
    if ([notification.name isEqualToString:kUserLoginWithCellPhoneNumber]) {
        NSLog(@"用户第三方手机号登录");
        return;
    }
    
    if ([notification.name isEqualToString:kUserLoginWithOther]) {
        NSLog(@"用户第三方其他登录");
        return;
    }
}


- (NSArray *)listNotificationInterests {
    return @[kUserLoginWithQQ,
             kUserLoginWithSina,
             kUserLoginWithWeiXin,
             kUserLoginWithOther,
             kUserLoginWithCellPhoneNumber];
}

+ (NSString *)NAME {
    return NSStringFromClass([self class]);
}

@end

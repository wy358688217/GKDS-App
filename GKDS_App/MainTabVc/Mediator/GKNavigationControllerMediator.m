//
//  GKNavigationControllerMediator.m
//  GKDS_App
//
//  Created by wang on 16/3/24.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKNavigationControllerMediator.h"
#import "GKNavigationControllerProxy.h"
#import "GKDiscoveryViewController.h"

@implementation GKNavigationControllerMediator

- (void)handleNotification:(id<INotification>)notification {
    if (IsEqualToString(notification.name, kPushToDiscoveryViewController)) {
        GKDiscoveryViewController * vc = [[GKDiscoveryViewController alloc]init];
        vc.title = @"发现";
        [[GK_NAV_PROXY fetchCurTopViewController].navigationController pushViewController:vc animated:YES];
        return;
    }
}

- (NSArray *)listNotificationInterests {
    return @[kPushToDiscoveryViewController];
}

+ (NSString *)NAME {
    return NSStringFromClass([self class]);
}

@end

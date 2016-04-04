//
//  GKUITabBarMediator.m
//  GKDS_App
//
//  Created by wang on 16/3/27.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKUITabBarMediator.h"
#import "UITabBar+GKBadge.h"
#import "GKNavigationControllerProxy.h"

@implementation GKUITabBarMediator

- (void)handleNotification:(id<INotification>)notification{
    
    [self.delegate changeSubViewsStatus:nil];
    
    NSString * notiName = [notification name];
    if (IsEqualToString(notiName,kShowTabBarBadgeWithIndex)) {
        int index = [notification type].intValue;
        NSNumber * number = (NSNumber *)[notification body];
        UITabBar * tabBar = [GK_NAV_PROXY fetchTabBarWithKey:@(index)];
        [tabBar showBadgeOnItemIndex:index number:number.intValue];
        return;
    }
    if (IsEqualToString(notiName,kHiddenTabBarBadgeWithIndex)) {
        int index = [notification type].intValue;
        UITabBar * tabBar = [GK_NAV_PROXY fetchTabBarWithKey:@(index)];
        [tabBar hideBadgeOnItemIndex:index];
        return;
    }
    
    if (IsEqualToString(notiName,kShowCurrentTabBarBadge)) {
        NSNumber * number = (NSNumber *)[notification body];
        UITabBar * tabBar = [GK_NAV_PROXY fetchCurTabBar];
        int index = [GK_NAV_PROXY getCurNavIndex];
        [tabBar showBadgeOnItemIndex:index number:number.intValue];
        return;
    }
    
    if (IsEqualToString(notiName,kHiddenCurrentTabBarBadge)) {
        int index = [GK_NAV_PROXY getCurNavIndex];
        UITabBar * tabBar = [GK_NAV_PROXY fetchCurTabBar];
        [tabBar hideBadgeOnItemIndex:index];
        return;
    }
}

- (NSArray *)listNotificationInterests {
    return @[kShowTabBarBadgeWithIndex,
             kHiddenTabBarBadgeWithIndex,
             kShowCurrentTabBarBadge,
             kHiddenCurrentTabBarBadge];
}

+ (NSString *)NAME {
    return NSStringFromClass([self class]);
}

@end

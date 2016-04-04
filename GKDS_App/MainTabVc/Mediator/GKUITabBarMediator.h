//
//  GKUITabBarMediator.h
//  GKDS_App
//
//  Created by wang on 16/3/27.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Mediator.h"
#import "GKViewControllerDelegate.h"

#define kShowTabBarBadgeWithIndex   @"kShowTabBarBadgeWithIndex"
#define kHiddenTabBarBadgeWithIndex @"kHiddenTabBarBadgeWithIndex"
#define kShowCurrentTabBarBadge     @"kShowCurrentTabBarBadge"
#define kHiddenCurrentTabBarBadge   @"kHiddenCurrentTabBarBadge"

@interface GKUITabBarMediator : Mediator
@property (nonatomic, assign) id<GKViewControllerDelegate> delegate;
@end

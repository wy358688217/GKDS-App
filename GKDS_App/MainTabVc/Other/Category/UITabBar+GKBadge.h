//
//  UITabBar+GKBadge.h
//  GKDS_App
//
//  Created by wang on 16/3/27.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (GKBadge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)showBadgeOnItemIndex:(int)index number:(int)number;
- (void)hideBadgeOnItemIndex:(int)index;
@end

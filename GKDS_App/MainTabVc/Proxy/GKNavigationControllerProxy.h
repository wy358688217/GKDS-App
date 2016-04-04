//
//  GKNavigationControllerProxy.h
//  GKDS_App
//
//  视图控制器代理类
//  Created by wang on 16/3/24.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Proxy.h"
#import "PPClient.h"
#import <UIKit/UIKit.h>


#define kGKNavigationControllerProxy @"kGKNavigationControllerProxy"
#define GK_NAV_PROXY ((GKNavigationControllerProxy*)PPCLIENT_PROXY(kGKNavigationControllerProxy))

typedef enum Moduel_Tab_Index{
    Moduel_Tab_Left_One         = 0,
    Moduel_Tab_Left_Two         = 1,
    Moduel_Tab_Left_Three       = 2,
    Moduel_Tab_Left_Four        = 3,
    Moduel_Tab_Left_Five        = 4,
    Moduel_Tab_Left_Default,
}Moduel_Tab_Index;

@interface GKNavigationControllerProxy : Proxy
/**
 *  设定当前所在tabbar下标枚举值
 *
 *  @param index tabbar下标枚举值 Moduel_Tab_Index
 */
- (void)setCurNavIndex:(Moduel_Tab_Index)index;

/**
 *  获取当前所在tabbar下标枚举值
 *
 *  @return 枚举 Moduel_Tab_Index
 */
- (Moduel_Tab_Index)getCurNavIndex;

/**
 *  缓存当前UIWindow
 *
 *  @param window UIWindow
 */
- (void)setCurWindow:(UIWindow *)window;

/**
 *  获取当前UIWindow
 *
 *  @return UIWindow
 */
- (UIWindow *)getCurWindow;

/**
 *  通过tabbar下标枚举值缓存当前 UINavigationController
 *
 *  @param navVc  当前根VC所在的UINavigationController->NSNumber
 *  @param number tabbar 的下标枚举值
 */
- (void)insertNavigationController:(UINavigationController *)navVc key:(NSNumber *)number;

/**
 *  根据对应tabbar下标枚举值从缓存池中取出对应UINavigationController
 *
 *  @param number 当前VC所在tabbar的下标枚举值->NSNumber
 *
 *  @return 返回对应的UINavigationController
 */
- (UINavigationController *)fetchNavigationControllerWithKey:(NSNumber *)number;

/**
 *  直接从取出当前视图所在的UINavigationController
 *
 *  @return UINavigationController
 */
- (UINavigationController *)getCurrentNavigationController;

/**
 *  取出对应tabbar最顶部的UIViewController
 *
 *  @param number 当前tabbar的下标枚举值->NSNumber
 *
 *  @return 返回对应的UIViewController
 */
- (UIViewController *)fetchTopViewControllerWithKey:(NSNumber *)number;

/**
 *  直接取出当前VC对应tabbar最顶部的UIViewController
 *
 *  @return 返回对应的UIViewController
 */
- (UIViewController *)fetchCurTopViewController;

/**
 *  根据tabbar下标枚举值取出对应UITabBar
 *
 *  @param number tabbar下标枚举值->NSNumber
 *
 *  @return 对应的UITabBar
 */
- (UITabBar *)fetchTabBarWithKey:(NSNumber *)number;

/**
 *  直接取出当前视图所在UITabBar
 *
 *  @return 当前视图所在UITabBar
 */
- (UITabBar *)fetchCurTabBar;

@end

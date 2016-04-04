//
//  GKNavigationControllerProxy.m
//  GKDS_App
//
//  Created by wang on 16/3/24.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKNavigationControllerProxy.h"

@implementation GKNavigationControllerProxy {
    Moduel_Tab_Index mNavIndex;
    UIWindow * _mpCurWindow;
    NSMutableDictionary<NSNumber * ,UINavigationController *> * _mpNavMap;
}

- (void)initializeProxy {
    mNavIndex = Moduel_Tab_Left_One;
    _mpNavMap = [[NSMutableDictionary alloc]initWithCapacity:6];
    GKLog(@"导航控制器代理类正常初始化");
}

- (void)setCurNavIndex:(Moduel_Tab_Index)index {
    mNavIndex = index;
}

- (Moduel_Tab_Index)getCurNavIndex {
    return mNavIndex;
}

- (void)setCurWindow:(UIWindow *)window {
    _mpCurWindow = window;
}

- (UIWindow *)getCurWindow {
    return _mpCurWindow;
}

- (void)insertNavigationController:(UINavigationController *)navVc key:(NSNumber *)number{
    [_mpNavMap setObject:navVc forKey:number];
}

- (UINavigationController *)fetchNavigationControllerWithKey:(NSNumber *)number {
    UINavigationController * nav = _mpNavMap[number];
    GKLog(@"当前导航控制器为空");
    PPAssert(nav != nil, @"当前导航控制器为空");
//    nav.topViewController
    return _mpNavMap[number];
}

- (UINavigationController *)getCurrentNavigationController {
    return [self fetchNavigationControllerWithKey:@(mNavIndex)];
}

- (UIViewController *)fetchTopViewControllerWithKey:(NSNumber *)number {
    UINavigationController * nav = _mpNavMap[number];
    NSArray * curVcArray = nav.viewControllers;
    UIViewController * topVc = nil;
    if (curVcArray.count > 0) {
        topVc = curVcArray.lastObject;
        return topVc;
    }
    GKLog(@"当前视图控制器为空");
    PPAssert(topVc != nil, @"当前视图控制器为空");
    return topVc;
}

- (UIViewController *)fetchCurTopViewController {
    UIViewController * topVc = [self fetchTopViewControllerWithKey:@(mNavIndex)];
    return topVc;
}

- (UITabBar *)fetchTabBarWithKey:(NSNumber *)number {
    UIViewController * vc = [self fetchTopViewControllerWithKey:number];
    PPAssert(vc != nil, @"当前视图控制器为空");
    UITabBar * bar = vc.tabBarController.tabBar;
    PPAssert(bar != nil, @"当前Tabbar为空");
    return bar;
}

- (UITabBar *)fetchCurTabBar {
    UITabBar * curBar = [self fetchTabBarWithKey:@(mNavIndex)];
    return curBar;
}

@end

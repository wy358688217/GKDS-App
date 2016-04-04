//
//  GKNavigationController.m
//  GKDS_App
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKNavigationController.h"
#import "GKDiscoveryViewController.h"
#import "GKAboutMeViewController.h"

@interface GKNavigationController ()//<UINavigationControllerDelegate>

@end

@implementation GKNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    UIViewController * lastVc = [super popViewControllerAnimated:animated];
    if (self.viewControllers.count == 1) {//为根控制器
        self.tabBarController.tabBar.hidden = NO;
    }
    return lastVc;
}

- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray * vcArray = [super popToRootViewControllerAnimated:animated];
    if (self.viewControllers.count == 1) {//为根控制器
        self.tabBarController.tabBar.hidden = NO;
    }
    return vcArray;
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray * vcArray = [super popToViewController:viewController animated:animated];
    if (self.viewControllers.count == 1) {//为根控制器
        self.tabBarController.tabBar.hidden = NO;
    }
    return vcArray;
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    NSString * className = NSStringFromClass(viewController.class);
    GKLog(className);
}

@end

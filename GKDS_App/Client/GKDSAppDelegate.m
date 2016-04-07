//
//  GKDSAppDelegate.m
//  GKDS_App
//
//  Created by wang on 16/3/22.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDSAppDelegate.h"
#import "GKLoginViewController.h"
#import "PPModule.h"
#import "PPClient.h"
#import "SystemField.h"
#import "XZMTabBarViewController.h"
#import "GKNavigationControllerProxy.h"
#import "GKLogUtils.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "GKDSLogFormatter.h"
#import "WXApi.h"
#import "WXApiManager.h"



@interface GKDSAppDelegate ()

@end

@implementation GKDSAppDelegate

- (void)dealloc
{
    [PPCLIENT sendNotification:kSystemCommandDeviceShutDown];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //GKLoginViewController XZMTabBarViewController
    self.window.rootViewController = [[GKLoginViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];

    
    [PPMODULE registerAllModules];
    [GK_NAV_PROXY setCurWindow:self.window];
    [PPCLIENT sendNotification:kSystemCommandDeviceStartUp];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [PPCLIENT sendNotification:kSystemCommandDeviceSleep];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [PPCLIENT sendNotification:kSystemCommandDeviceWakeup];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [PPCLIENT sendNotification:kSystemCommandDeviceDidBecomeActive];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [PPCLIENT sendNotification:kSystemCommandMemoryWarning];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

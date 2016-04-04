//
//  GKDeviceCommand.m
//  GKDS_App
//
//  Created by wang on 16/3/22.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDeviceCommand.h"
#import "GKDSLogFormatter.h"
#import "UncaughtExceptionHandler.h"

@implementation DeviceStartUpCommand

- (void)execute:(id<INotification>)notification {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[GKDSLogFormatter getGKDSLogFormatter] initDDLog];
    });
    GKLog(@"系统启动正常启动");
    NSSetUncaughtExceptionHandler(&HandleException);
    GKLog(@"监听Exception崩溃信息成功");
    InstallUncaughtExceptionHandler();
    GKLog(@"监听Unix底层抛出Signal信号成功");
}

@end

@implementation DeviceShutDownCommand

-(void)execute:(id<INotification>)notification {
    GKLog(@"系统关闭命令");
}

@end

@implementation DeviceSleepCommand

-(void)execute:(id<INotification>)notification {
    GKLog(@"系统睡眠进入后台命令");
}

@end

@implementation DeviceWakeupCommand

- (void)execute:(id<INotification>)notification {
    GKLog(@"系统苏醒进入前台命令");
}

@end

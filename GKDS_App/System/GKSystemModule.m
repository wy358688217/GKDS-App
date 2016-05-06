//
//  GKSystemModule.m
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKSystemModule.h"
#import "GKSystemProxy.h"
#import "GKDeviceCommand.h"
#import "GKUserDataCommand.h"
#import "SystemField.h"
#import "GKDataBaseProxy.h"

@implementation GKSystemModule

- (void)onRegister {
    [self registerProxy:[GKSystemProxy withProxyName:kGKSystemProxy]];
    [self registerProxy:[GKDataBaseProxy withProxyName:kGKDataBaseProxy]];
    [self registerCommand:kSystemCommandDeviceStartUp withCommand:[DeviceStartUpCommand class]];
    [self registerCommand:kSystemCommandDeviceShutDown withCommand:[DeviceShutDownCommand class]];
    [self registerCommand:kSystemCommandDeviceSleep withCommand:[DeviceSleepCommand class]];
    [self registerCommand:kSystemCommandDeviceWakeup withCommand:[DeviceWakeupCommand class]];
    [self registerCommand:kSystemCommandLoadUserData withCommand:[LoadUserDataCommand class]];
    [self registerCommand:kSystemCommandSaveUserData withCommand:[SaveUserDataCommand class]];
}

- (void)onRemove {
    [self removeAllProxy];
    [self removeAllCommand];
}

@end

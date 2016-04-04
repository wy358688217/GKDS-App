//
//  GKDeviceCommand.h
//  GKDS_App
//
//  Created by wang on 16/3/22.
//  文件说明: 设备消息都在这里处理
//  Copyright © 2016年 wang. All rights reserved.
//

#import "SimpleCommand.h"

@interface DeviceStartUpCommand : SimpleCommand
@end

@interface DeviceShutDownCommand : SimpleCommand
@end

@interface DeviceSleepCommand : SimpleCommand
@end

@interface DeviceWakeupCommand : SimpleCommand
@end

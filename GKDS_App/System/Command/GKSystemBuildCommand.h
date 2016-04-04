//
//  GKSystemBuildCommand.h
//  GKDS_App
//
//  Created by wang on 16/3/22.
// 文件说明: 负责注册系统用Proxy和Command和Mediator
//  Copyright © 2016年 wang. All rights reserved.
//

#import "SimpleCommand.h"

#define kModuleRegisterCommand @"kModuleRegisterCommand"
@interface ModuleRegisterCommand : SimpleCommand
@end

#define kModuleUnRegisterCommand @"kModuleUnRegisterCommand"
@interface ModuleUnRegisterCommand : SimpleCommand
@end

#define kSystemProxyBuildCommand @"kSystemProxyBuildCommand"
@interface SystemProxyBuildCommand : SimpleCommand
@end

#define kSystemProxyReBuildCommand @"kSystemProxyReBuildCommand"
@interface SystemProxyReBuildCommand : SimpleCommand
@end

#define kSystemCommandBuildCommand @"kSystemCommandBuildCommand"
@interface SystemCommandBuildCommand : SimpleCommand
@end

#define kSystemCommandReBuildCommand @"kSystemCommandReBuildCommand"
@interface SystemCommandReBuildCommand : SimpleCommand
@end

#define kSystemMediatorBuildCommand @"kSystemMediatorBuildCommand"
@interface SystemMediatorBuildCommand : SimpleCommand
@end

#define kSystemMediatorReBuildCommand @"kSystemMediatorReBuildCommand"
@interface SystemMediatorReBuildCommand : SimpleCommand
@end

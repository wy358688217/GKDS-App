
// $_FILEHEADER_BEGIN ***************************
// 版权声明:北京畅聊天下科技有限公司版权所有
// Copyright (C) 2012-  Changliao Technology Co.Ltd. All Rights Reserved
// 文件名称: SystemField.h
// 创建日期: 20150320 15:11
// 代码作者: wang
// 文件说明: MVC - 系统字段
// $_FILEHEADER_END *****************************

#ifndef __PP_SYSTEM_FIELD_H__
#define __PP_SYSTEM_FIELD_H__

#define IsStringEqual(str1,str2) [str1 isEqualToString:str2]
#define IsClassOf(obj,class_type) [obj isKindOfClass:[class_type class]]

// system command
#define kSystemCommandDeviceStartUp @"kSystemCommandDeviceStartUp"
#define kSystemCommandDeviceShutDown @"kSystemCommandDeviceShutDown"
#define kSystemCommandDeviceSleep @"kSystemCommandDeviceSleep"
#define kSystemCommandDeviceWakeup @"kSystemCommandDeviceWakeup"
#define kSystemCommandDeviceDidBecomeActive @"kSystemCommandDeviceDidBecomeActive"
#define kSystemCommandLoadUserData @"kSystemCommandLoadUserData"
#define kSystemCommandSaveUserData @"kSystemCommandSaveUserData"
#define kSystemCommandMemoryWarning @"kSystemCommandMemoryWarning"
#define kSystemCommandMakeFirstView @"kSystemCommandMakeFirstView"
#define kSystemCommandRecheckAllServerData @"kSystemCommandRecheckAllServerData"

// system mediator
#define kSystemMediatorVersionCheck @"kSystemMediatorVersionCheck"
#define kSystemMediatorUserRegister @"kSystemMediatorUserRegister"
#define kSystemMediatorLocalNotification @"kSystemMediatorLocalNotification"
#define kSystemMediatorRemoteNotification @"kSystemMediatorRemoteNotification"
#define kSystemMediatorPhoneCallAdapter @"kSystemMediatorPhoneCallAdapter"
#define kSystemMediatorUserAppeal @"kSystemMediatorUserAppeal"

#endif

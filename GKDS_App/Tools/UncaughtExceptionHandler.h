//
//  UncaughtExceptionHandler.h
//  GKDS_App
//  文件说明: 抓取Signal特殊异常崩溃
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
@end

NSString* getAppInfo();
void HandleException(NSException *exception);
void MySignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);



//
//  GKDSLogFormatter.m
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDSLogFormatter.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

#define DATE_STRING @"yyyy-MM-dd HH:mm:ss.SSS"

@interface GKDSLogFormatter ()

@end

@implementation GKDSLogFormatter{
    NSDateFormatter *threadUnsafeDateFormatter;
}
HMSingletonM(GKDSLogFormatter)
- (void)initDDLog {
    
    threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
    [threadUnsafeDateFormatter setDateFormat:DATE_STRING];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;//
//    [DDLog addLogger:fileLogger];
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance] setForegroundColor:UIColorFromRGB(0xC7EDCC) backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    [DDTTYLogger sharedInstance].logFormatter = self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    NSString * queueLabel = logMessage.queueLabel;
    NSString * str = [NSString stringWithFormat:@"%@|Thread:%@ line:%lu",logMessage->_function,queueLabel, (unsigned long)logMessage->_line];
    NSString * dateAndTime = [threadUnsafeDateFormatter stringFromDate:(logMessage->_timestamp)];
    return [NSString stringWithFormat:@"%@-%@:\n%@",dateAndTime, str, logMessage->_message];
}
@end








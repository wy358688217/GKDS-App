//
//  GKLogUtils.m
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKLogUtils.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

@interface GKLogUtils ()

@end

@implementation GKLogUtils
//HMSingletonM(GKLogUtils)

/**
 *  日志的级别有如下几种：
 *
 *  LOG_LEVEL_ERROR：如果设置为LOG_LEVEL_ERROR，仅仅能看到Error相关的日志输出。
 *  LOG_LEVEL_WARN：如果设置为LOG_LEVEL_WARN，能看到Error、Warn相关的日志输出。
 *  LOG_LEVEL_INFO：如果设置为LOG_LEVEL_INFO，能够看到Error、Warn、Info相关的日志输出。
 *  LOG_LEVEL_DEBUG：如果设置为LOG_LEVEL_DEBUG，能够看到Error/Warn/Info/Debug相关的日志输出。
 *  LOG_LEVEL_VERBOSE：如果设置为LOG_FLAG_VERBOSE，能够看到所有级别的日志输出。
 *  LOG_LEVEL_OFF:不输出日志。
 *
 */
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

+ (void)initialize
{
    if (self == [GKLogUtils class]) {
        
        [DDLog addLogger:[DDASLLogger sharedInstance]];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 1;//
        
        [DDLog addLogger:fileLogger];
        [DDTTYLogger sharedInstance].colorsEnabled = YES;
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:DDLogFlagError];
        [[DDTTYLogger sharedInstance] setForegroundColor:UIColorFromRGB(0xC7EDCC) backgroundColor:nil forFlag:DDLogFlagVerbose];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:DDLogFlagWarning];
        [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
        
        DDLogError(@"Error");//红色
        DDLogWarn(@"Warn");//黄色
        DDLogInfo(@"Info");//默认是黑色
        DDLogDebug(@"Debug");//默认是黑色
        DDLogVerbose(@"Verbose");//默认是黑色
        //#define GKLog(STRLOG) NSLog(@"%@: %@ %@", self, NSStringFromSelector(_cmd), STRLOG)

    }
}

+ (void)write:(NSString *)string {
//    NSString * infoStr = [NSString stringWithFormat:@"%@: %@ %@", self, NSStringFromSelector(_cmd), string];
    DDLogInfo(string);
}
@end








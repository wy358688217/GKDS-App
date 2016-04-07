//
//  UncaughtExceptionHandler.m
//  GKDS_App
//  文件说明: 抓取Signal特殊异常崩溃
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import "GKSystemProxy.h"
#import "PPClient.h"
#import "GKNavigationControllerProxy.h"

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";
volatile int64_t UncaughtExceptionCount = 0;
const int64_t    UncaughtExceptionMaximum = 100;
const NSInteger  UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger  UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler{
    BOOL dismissed;
}

+ (NSArray *)backtrace {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char ** strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0/*UncaughtExceptionHandlerSkipAddressCount*/; i < UncaughtExceptionHandlerSkipAddressCount +          UncaughtExceptionHandlerReportAddressCount; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex {
    if (anIndex == 0) {
        dismissed = YES;
    } else if (anIndex == 1) {
        dismissed = NO;
        GKLog(@"no dismissed");
    }
}

- (void)validateAndSaveCriticalApplicationData:(NSException *)exception {
    //保存异常
    NSArray * stackArray = [exception  callStackSymbols];// 异常的堆栈信息
    NSArray * stackArrayAddress = [exception callStackReturnAddresses];// 异常的堆栈信息地址
    NSString * reason = [exception reason];// 出现异常的原因
    NSString * name = [exception name];// 异常名称
    NSString * iphoneInfo = getAppInfo();//手机型号
    
//    UINavigationController * curNav = [GK_NAV_PROXY getCurrentNavigationController];
//    Moduel_Tab_Index tabBarIndex = GK_NAV_PROXY.getCurNavIndex;
//    NSArray<UIViewController *> * curVcArray = curNav.viewControllers;
//    NSMutableArray<NSString *> * vcNameArray = [[NSMutableArray alloc]initWithCapacity:curVcArray.count];
//    int i = 0;
//    for (UIViewController * vc in curVcArray) {
//        NSString * vcName = [NSString stringWithUTF8String:object_getClassName(vc)];
//        [vcNameArray addObject:vcName];
//        GKLogSP(@"当前VC栈元素依次是%d:%@",i,vcName);
//        i++;
//    }
    NSString * dateStr = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:dateStr];
    NSString * dateAndTime = [df stringFromDate:[NSDate date]];

    NSString * exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@\nExceptionAddress stack：%@\niPhoneInfo:%@\n CrashTime:%@",name, reason, stackArray,stackArrayAddress,iphoneInfo,dateAndTime];
    GKLogSP(@"捕获到的异常日志:%@", exceptionInfo);
    
    //在此可以发送给服务器后者发送指定邮箱
    //写入本地
    [self saveCrash:exceptionInfo];
}

- (void)saveCrash:(NSString *)exceptionInfo {
    NSString * _libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Crash"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
        
    NSString * dateStr = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:dateStr];
    NSString * dateAndTime = [df stringFromDate:[NSDate date]];

    NSString * savePath = [_libPath stringByAppendingFormat:@"/error-%@.log",dateAndTime];
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (sucess){
        GKLog(@"异常日志写入成功!");
    }
    else{
        GKLog(@"异常日志写入失败!");
    }
}

- (void)handleException:(NSException *)exception {
    [self validateAndSaveCriticalApplicationData:exception];
    BOOL isPublicNet = [GK_SYS_PROXY curNetEnvironment];
    NSString * msg = [NSString stringWithFormat:NSLocalizedString(
                                                                  @"如果点击继续，大师有可能会出现其他的问题，建议您还是点击退出按钮并重新打开\n\n"
                                                                  @"异常原因如下:\n%@\n%@\n%@\n%@\n%@", nil),
                      [exception name],
                      [exception reason],
                      [NSThread callStackSymbols],
                      [NSThread callStackReturnAddresses],
                      [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]];
    
    //目前内外网同一处理 外网只有退出按钮 内网有继续按钮  形象的说继续就能憋住继续运行下去(接管当前runLoop)
    if (!isPublicNet){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"抱歉，国考大师出现了异常", nil)
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"退出", nil)
                                               otherButtonTitles:NSLocalizedString(@"继续", nil), nil];
        [alert show];
        CFRunLoopRef runLoop = CFRunLoopGetCurrent();
        CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
        while (!dismissed) {
            for (NSString *mode in (NSArray *) CFBridgingRelease(allModes)) {
                CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
            }
        }
        CFRelease(allModes);
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"抱歉，国考大师出现了异常", nil)
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"退出", nil)
                                               otherButtonTitles:nil,nil];
        [alert show];
        CFRunLoopRef runLoop = CFRunLoopGetCurrent();
        CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
        while (!dismissed)  {
            for (NSString *mode in (NSArray *) CFBridgingRelease(allModes)) {
                CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
            }
        }
        CFRelease(allModes);
    }
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])  {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] integerValue]);
    } else {
        [exception raise];
    }
}
@end

#pragma mark -- 以下为C/C++全局函数
NSString* getAppInfo() {
    NSString * appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\nUDID : %@\n",
                          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                          [UIDevice currentDevice].model, [UIDevice currentDevice].systemName,
                          [UIDevice currentDevice].systemVersion,
                          [UIDevice currentDevice].identifierForVendor];
    NSLog(@"Crash!!!!line:%d:%s--%@",__LINE__,__func__,appInfo);
    return appInfo;
}

void MySignalHandler(int signal) {
    int64_t exceptionCount = OSAtomicIncrement64(&UncaughtExceptionCount);
    if (exceptionCount >= UncaughtExceptionMaximum) return;
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]
                                                                        forKey:UncaughtExceptionHandlerSignalKey];
    NSArray * callStack = [UncaughtExceptionHandler backtrace];
    NSLog(@"callStack:%@",callStack);
    [userInfo setObject:callStack forKey:UncaughtExceptionHandlerAddressesKey];
    
    NSString * msg = [NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.\n" @"%@", nil), signal, getAppInfo()];
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
     withObject:[NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                                        reason:msg
                                      userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:signal]
                                                                           forKey:UncaughtExceptionHandlerSignalKey]]

    waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler() {
    signal(SIGABRT, MySignalHandler);
    signal(SIGILL, MySignalHandler);
    signal(SIGSEGV, MySignalHandler);
    signal(SIGFPE, MySignalHandler);
    signal(SIGBUS, MySignalHandler);
    signal(SIGPIPE, MySignalHandler);
}

void HandleException(NSException *exception) {
    int64_t exceptionCount = OSAtomicIncrement64(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) return;
    NSArray *callStack = [UncaughtExceptionHandler backtrace];
    NSLog(@"callStack:line:%d:%s--%@",__LINE__,__func__,callStack);
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    userInfo[UncaughtExceptionHandlerAddressesKey] = callStack;
    [[[UncaughtExceptionHandler alloc] init] performSelectorOnMainThread:@selector(handleException:)
     withObject: [NSException exceptionWithName:[exception name]
                                         reason:[exception reason]
                                       userInfo:userInfo]
     waitUntilDone:YES];
}

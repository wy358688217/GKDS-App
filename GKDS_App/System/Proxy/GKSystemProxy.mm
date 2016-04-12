//
//  GKSystemProxy.m
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKSystemProxy.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <GLKit/GLKit.h>

#import <mach/mach.h>
#import <sys/sysctl.h>
#import "ALProcessor.h"
#import "ALMemory.h"
#import "ALHardware.h"
#import "Reachability.h"

#include "ifaddrs.h"
#include "net/if.h"
#include <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#import "SystemConstants.h"

@implementation GKSystemProxy {
    BOOL isPublicNet;
}

- (void)initializeProxy {
    isPublicNet = NO;
}

- (BOOL)curNetEnvironment {
    return isPublicNet;
}

- (NSString *)curNetStatus {
    NSString * netconnType = @"暂时无法获取";
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            
            netconnType = @"no network";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString * currentStatus = info.currentRadioAccessTechnology;
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS])netconnType = @"GPRS";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge])netconnType = @"2.75G EDGE";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA])netconnType = @"3G";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA])netconnType = @"3.5G HSDPA";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA])netconnType = @"3.5G HSUPA";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x])netconnType = @"2G";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0])netconnType = @"3G";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA])netconnType = @"3G";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB])netconnType = @"3G";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD])netconnType = @"HRPD";
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE])netconnType = @"4G";        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
}

- (NSArray<NSNumber *>*)netBandData {
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return 0;
    }
    
    NSInteger iBytes = 0;
    NSInteger oBytes = 0;
    //监控显卡上下行流量
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family) continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))  continue;
        if (ifa->ifa_data == 0) continue;
        
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    return @[@(iBytes),@(oBytes)];
}

- (void)curNetSpeed:(GKSystemProxyCallback) callback {
    NSArray<NSNumber *> * arr1 = [self netBandData];
    __block NSInteger  iBytesForLast = arr1[0].integerValue;
    __block NSInteger  oBytesForLast = arr1[1].integerValue;
    
    WEAK_BLOCK_OBJECT(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BLOCK_OBJECT(self);
        NSArray<NSNumber *> * arr2 = [weak_self netBandData];
        NSInteger iBytesForNew = arr2[0].integerValue;
        NSInteger oBytesForNEw = arr2[1].integerValue;
        
        NSInteger  iIncreaseValue = iBytesForNew - iBytesForLast;
        NSInteger  oIncreaseValue = oBytesForNEw - oBytesForLast;
        
        if (iIncreaseValue < 0) iIncreaseValue = 0;
        if (oIncreaseValue < 0) oIncreaseValue = 0;
        
        NSString * dowdloadSpeed = [weak_self humanReadableSpeedFromSpeed:iIncreaseValue];
        NSString * uploadSpeed = [weak_self humanReadableSpeedFromSpeed:oIncreaseValue];
        
        if (callback) {
            callback(dowdloadSpeed,uploadSpeed);
        }
    });
}

- (NSString *)humanReadableSpeedFromSpeed:(double)speed
{
    static NSArray *speedMeasures = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        speedMeasures = (@[
                           NSLocalizedString(@"B/s", @""),
                           NSLocalizedString(@"KB/s", @""),
                           NSLocalizedString(@"MB/s", @""),
                           NSLocalizedString(@"GB/s", @"")
                           ]);
    });
    
    int counter = 0;
    while (counter < speedMeasures.count - 1 && speed > 900.0) {
        speed /= 1024.0;
        counter++;
    }
    return [NSString stringWithFormat:@"%.1f %@", speed, speedMeasures[counter]];
}

- (NSString *)curNetworkOperators {
    CTTelephonyNetworkInfo * telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier * carrier = [telephonyInfo subscriberCellularProvider];
    NSString * operatorsName =[carrier carrierName];
    NSString * counteyCode = carrier.isoCountryCode;
    NSString * networkCode = carrier.mobileNetworkCode;
    if (operatorsName.length > 0) return operatorsName;
    if ([counteyCode isEqualToString:@"cn"]) {
        if ([networkCode isEqualToString:@"00"]) operatorsName = @"中国移动";
        if ([networkCode isEqualToString:@"02"]) operatorsName = @"中国移动";
        if ([networkCode isEqualToString:@"07"]) operatorsName = @"中国移动";
        if ([networkCode isEqualToString:@"01"]) operatorsName = @"中国联通";
        if ([networkCode isEqualToString:@"06"]) operatorsName = @"中国联通";
        if ([networkCode isEqualToString:@"09"]) operatorsName = @"中国联通";
        if ([networkCode isEqualToString:@"03"]) operatorsName = @"中国电信";
        if ([networkCode isEqualToString:@"05"]) operatorsName = @"中国电信";
        if ([networkCode isEqualToString:@"11"]) operatorsName = @"中国电信";
        if ([networkCode isEqualToString:@"20"]) operatorsName = @"中国铁通";
        if ([networkCode isEqualToString:@"04"]) operatorsName = @"全球卫星电话";
    }
    return operatorsName;
}

- (NSString *)curClientVersion {
    NSString * ver1 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * ver2 = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * version = ver1.length > 0 ? ver1 : ver2;
    return version;
}

- (NSString *)curIOSVersion {
    NSString * systemName = [NSString stringWithFormat:@"%@ %@",[ALHardware systemName],[ALHardware systemVersion]];
    return systemName;
}

- (NSInteger)curCPUCount {
    return [[NSProcessInfo processInfo] processorCount];
}

- (NSString *)curCPUUsageForApp {
    CGFloat tot_cpu = [ALProcessor cpuUsageForApp]*100;
    return [NSString stringWithFormat:@"%.2f％",tot_cpu];
}

- (NSString *)curPhoneMemorySize {
    NSInteger totalMemory = [ALMemory totalMemory];
    return [NSString stringWithFormat:@"%ldMB",(long)totalMemory];
}

- (NSString *)curMemoryUsageForApp {
    NSInteger usedMemory = [ALMemory usedMemory];
    NSInteger totalMemory = [ALMemory totalMemory];
    CGFloat per = usedMemory * 100 / totalMemory;
    return [NSString stringWithFormat:@"当前手机使用内存为%ldMB，占总内存%.2f％",(long )usedMemory,per];
}

- (NSString *)curPhoneGPUModel {
    EAGLContext * ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:ctx];
    return [NSString stringWithCString:(const char*)glGetString(GL_VERSION) encoding:NSASCIIStringEncoding];
}

- (NSString *)curPhoneGPUName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * result = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    iDevice_t dev = MachineToIdevice(result);
    NSString * gpuName = (NSString *)GraphicCardNameTable[dev];
    return gpuName;
}

- (NSString *)curPhoneGPUSize {    
    return @"暂时无法获取";
}

- (NSString *)curPhoneBrand {

    return [ALHardware deviceModel];
}

- (NSString *)curPhoneModel {
    return [ALHardware platformType];
}

@end

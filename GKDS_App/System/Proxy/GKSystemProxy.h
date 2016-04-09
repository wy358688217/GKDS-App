//
//  GKSystemProxy.h
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Proxy.h"
#define kGKSystemProxy @"kGKSystemProxy"
#define GK_SYS_PROXY ((GKSystemProxy*)PPCLIENT_PROXY(kGKSystemProxy))

typedef void(^GKSystemProxyCallback)(NSString * downloadSpeed, NSString * uploadSpeed);

@interface GKSystemProxy : Proxy
/**
 *  区分内外网
 *
 *  @return 内外网环境布尔值
 */
- (BOOL)curNetEnvironment;
/**
 *  获取网络运行状态 0 - 无网络 ; 1 - 2G ; 2 - 3G ; 3 - 4G ; 5 - WIFI
 *
 *  @return 返回当前网络的字符串
 */
- (NSString *)curNetStatus;
/**
 *  当前时间点下载网速大小 格式:B/s KB/s MB/s GB/s
 *  当前时间点上传网速大小 格式:B/s KB/s MB/s GB/s
 */
- (void)curNetSpeed:(GKSystemProxyCallback) callback;
/**
 *  当前网络运营商 比如：中国移动、电信、联通等
 *
 *  @return 返回当前网络运营商字符串
 */
- (NSString *)curNetworkOperators;
/**
 *  当前客户端版本号
 *
 *  @return 返回当前客户端版本号字符串
 */
- (NSString *)curClientVersion;
/**
 *  当前客户端操作系统版本号
 *
 *  @return 返回当前客户端操作系统版本号字符串
 */
- (NSString *)curIOSVersion;
/**
 *  当前CPU数量
 *
 *  @return 返回当前CPU数量字符串
 */
- (NSInteger)curCPUCount;
/**
 *  当前该应用程序运行所占CPU百分比
 *
 *  @return 返回该应用程序运行所占CPU百分比字符串
 */
- (NSString *)curCPUUsageForApp;
/**
 *  当前手机内存大小 格式:MB、GB
 *
 *  @return 返回当前手机内存大小字符串
 */
- (NSString *)curPhoneMemorySize;
/**
 *  当前该应用程序运行所占内存百分比
 *
 *  @return 返回该应用程序运行所占内存百分比字符串
 */
- (NSString *)curMemoryUsageForApp;
/**
 *  当前手机显卡型号
 *
 *  @return 返回当前手机显卡型号字符串
 */
- (NSString *)curPhoneGPUModel;
/**
 *  当前手机显卡名字
 *
 *  @return 返回当前手机显卡名字字符串
 */
- (NSString *)curPhoneGPUName;
/**
 *  当前手机显存大小
 *
 *  @return 返回当前手机显存大小字符串
 */
- (NSString *)curPhoneGPUSize;
/**
 *  当前手机品牌
 *
 *  @return 返回当前手机品牌字符串
 */
- (NSString *)curPhoneBrand;
/**
 *  当前手机型号
 *
 *  @return 返回当前手机型号字符串
 */
- (NSString *)curPhoneModel;
@end


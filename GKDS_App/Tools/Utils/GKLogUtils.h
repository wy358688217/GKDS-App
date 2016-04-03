//
//  GKLogUtils.h
//  GuoKao
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 XH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SafeSingleton.h"

@interface GKLogUtils : NSObject
HMSingletonH(GKLogUtils)

/**
 *  将stderr输出重定向到文件，即默认日志NSLog输出到文件ITLog.txt和GKLogbak.txt
 */
+ (void)switchStderrToFile;


/**
 *  返回系统启动到现在的时间，
 *
 *  @return 单位纳秒(Nanos) 0.000 001 毫秒 = 1纳秒
 */
+ (UInt64)getCurrentTime;

/**
 *  返回系统启动到现在的时间
 *
 *  @return 单位秒
 */
+ (double)getCurrentTimeForM;

/**
 *  检查日志文件大小，保证不会因为日志文件过大浪费用户空间
 *  也避免影响性能问题 目前单个日志文件<200kb左右
 */
+ (void)checkLogFileSize;

/**
 *  当前代码打时间戳endTag时返回这两次调用的时间差单位毫秒
 *
 *  @param tagStr 标记日志字符串
 *
 *  @return 返回tagId
 */
- (unsigned long)beginTag:(NSString *)tagStr;


/**
 *  根据tagId输入日志并返回耗时单位毫秒
 *
 *  @param tagId     调用beginTag得到的
 *  @param isShowLog YES将beginTag传入的tagStr做为日志输出
 *
 *  @return 返回耗时单位毫秒
 */
- (float)endTag:(unsigned long)tagId isShowLog:(BOOL)isShowLog;

/**
 *  清除所有tag
 */
- (void)clearTags;

@end

@class GKLogUtilsItem;
@interface GKLogUtils(Private)
- (GKLogUtilsItem *)findTagItemByTagId:(unsigned long)tagId;
- (void)showTagLog:(GKLogUtilsItem *)tagItem;
@end

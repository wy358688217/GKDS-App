//
//  GKLogUtils.m
//  GuoKao
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 XH. All rights reserved.
//

#import "GKLogUtils.h"
#import "CAHostTimeBase.h"

// 最大单个日志文件大小
#define kMaxLogFileSize 1024*1024*2

@interface GKLogUtilsItem : NSObject
@property (nonatomic, readwrite) unsigned long tagId;
/* beginNSThread endNSThread 用于判断是否是在同一线程中*/
@property (nonatomic, readwrite) unsigned long beginNSThread;
@property (nonatomic, readwrite) unsigned long endNSThread;
@property (nonatomic, retain) NSString *tagStr;
@property (nonatomic, readwrite) UInt64 beginTime;
@property (nonatomic, readwrite) float elapsedTime;
@end

@implementation GKLogUtilsItem
- (void)dealloc
{
    _tagStr = nil;
}
@end

/**
 *  开关控制是否写入文件
 *  YES : 写入文件 即沙盒 控制台不会进行输出
 *  NO : 控制台输出 不会写入文件 即沙盒
 */
static BOOL whetherNeedWriteToFile = NO;
static BOOL needCheckLogFileSize = NO;
static NSMutableArray *_spTagList;
static unsigned long geneId;

@implementation GKLogUtils

HMSingletonM(GKLogUtils)

+ (void)initialize
{
    if (self == [GKLogUtils class]) {
        geneId = 0;
        _spTagList = [[NSMutableArray alloc]init];
    }
}

- (void)dealloc {
    
    [self clearTags];
}

+ (void)switchStderrToFile {
    if (!whetherNeedWriteToFile) {
        return;
    }
#if TARGET_IPHONE_SIMULATOR
    // 模拟器上 暂时就不用日志文件了
    needCheckLogFileSize = NO;
#else
    // 真机上直接重定向日志到文件
    NSString *paths =  NSTemporaryDirectory();// NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *logPath = [paths stringByAppendingPathComponent:@"GKDS.log"] ;
    NSString *logbakPath = [paths stringByAppendingPathComponent:@"GKDS_Bak.log"] ;
    
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:logPath]) {
        BOOL needBakLogFile = NO;
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:logPath error:&error];
        if(fileAttributes != nil) {
            NSNumber *fileSize = [fileAttributes objectForKey:NSFileSize];
            // 大于200KB时切换log文
            needBakLogFile = ([fileSize unsignedLongLongValue] > kMaxLogFileSize);
        }
        if (needBakLogFile) {
            // 使日志文件控制在200KB * 2左右
            [fileManager removeItemAtPath:logbakPath error:&error];
            // 改名效率会高些
            [fileManager moveItemAtPath:logPath toPath:logbakPath error:&error];
        }
    }
    // 将日志文件重定向到文件
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    needCheckLogFileSize = YES;
#endif
}

+ (void)checkLogFileSize {
#if TARGET_IPHONE_SIMULATOR
    // 模拟器上暂时就不用日志文件了
#else
    // 真机上Release模式下直接重定向日志到文件
    if (needCheckLogFileSize == YES) {
        [self.class switchStderrToFile];
    }
#endif
}

+ (UInt64)getCurrentTime {
    return CAHostTimeBase::GetCurrentTimeInNanos();
}

+ (double)getCurrentTimeForM {
    // 在模拟器中CAHostTimeBase::GetCurrentTime()返回的值与在真机中不一样
    double result = CAHostTimeBase::GetCurrentTimeInNanos() / 1000000000.0f;
    return result;
}

- (unsigned long)beginTag:(NSString *)tagStr {
    unsigned long tagId;
    @synchronized(self) {
        tagId = geneId++;
        GKLogUtilsItem *tagItem = [[GKLogUtilsItem alloc] init];
        tagItem.tagId = tagId;
        tagItem.tagStr = tagStr;
        tagItem.beginNSThread = (unsigned long)[NSThread currentThread];
        tagItem.endNSThread = 0;
        tagItem.beginTime = CAHostTimeBase::GetCurrentTimeInNanos();
        tagItem.elapsedTime = 0.0f;
        [_spTagList addObject:tagItem];
    }
    return tagId;
}

- (float)endTag:(unsigned long)tagId isShowLog:(BOOL)isShowLog {
    float elapsedTime = 0.0f;
    @synchronized(self) {
        GKLogUtilsItem *tagItem = [self findTagItemByTagId:tagId];
        if (tagItem) {
            tagItem.endNSThread = (unsigned long)[NSThread currentThread];
            // 耗时单位毫秒
            elapsedTime = (CAHostTimeBase::GetCurrentTimeInNanos() - tagItem.beginTime) / 1000000.0f;
            tagItem.elapsedTime = elapsedTime;
            if (isShowLog) {
                [self showTagLog:tagItem];
            }
        }
    }
    return elapsedTime;
}

- (void)clearTags {
    @synchronized(self) {
        [_spTagList removeAllObjects];
    }
}
@end


//////////////////////////////////////////////////////////////////////
//  分类 -- GKLogUtils(Private)
//////////////////////////////////////////////////////////////////////

@implementation GKLogUtils(Private)
- (GKLogUtilsItem *)findTagItemByTagId:(unsigned long)tagId {

    GKLogUtilsItem *result = nil;
    for (GKLogUtilsItem *item in _spTagList) {
        if ( tagId == item.tagId ) {
            result = item;
            break;
        }
    }
    return result;
}

- (void)showTagLog:(GKLogUtilsItem *)tagItem {
    if ( tagItem.beginNSThread == tagItem.endNSThread ) {
        GKLog(([NSString stringWithFormat:@"[%lu] %lx> %@ elapsedTime:%.2fms", tagItem.tagId, tagItem.beginNSThread, tagItem.tagStr, tagItem.elapsedTime]));
    } else {
        GKLog(([NSString stringWithFormat:@"[%lu](beginNSThread=%lx != endNSThread=%lx)> %@ elapsedTime:%.2fms", tagItem.tagId, tagItem.beginNSThread, tagItem.endNSThread,  tagItem.tagStr, tagItem.elapsedTime]));
    }
}
@end

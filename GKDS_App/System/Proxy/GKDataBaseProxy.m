//
//  GKDataBaseProxy.m
//  GKDS_App
//
//  Created by wang on 16/5/1.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDataBaseProxy.h"
#import "FMDB.h"
#import "PPClient.h"
#define DNNAME @"GKDS.db"

@implementation GKDataBaseProxy {
    FMDatabase * DB;
    NSString * dataBasePath;
}

- (void)initializeProxy {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documents = [paths firstObject];
    dataBasePath = [documents stringByAppendingPathComponent:DNNAME];
    FMDatabase * dataBase = [FMDatabase databaseWithPath:dataBasePath];
    DB = dataBase;
}

- (BOOL)openDB {
    return [DB open];
}

- (BOOL)closeDB {
    return [DB close];
}

- (BOOL)executeUpdate:(NSString *)sql {
    if ([DB open]) {
        BOOL bVlaue = [DB executeUpdate:sql];
        [DB close];
        return bVlaue;
    }
    return NO;
}

- (id)executeQuery:(NSString *)sql {
    if ([DB open]) {
        FMResultSet * rs = [DB executeQuery:sql];
        [DB close];
        return rs;
    }
    return nil;
}

- (void)multiThreadExecuteUpdate:(NSString *)sql callback:(void (^)(BOOL successed))callback {
    FMDatabaseQueue * queue_DB = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    dispatch_queue_t queue_t = dispatch_queue_create("multiThreadExecuteUpdate", NULL);
    __block NSString * sql_block = sql;
    dispatch_async(queue_t, ^{
        [queue_DB inDatabase:^(FMDatabase *db) {
            BOOL isOPen = [db open];
            if (isOPen) {
                GKLogSP(@"执行语句%@时,打开数据库成功",sql_block);
                BOOL bRet = [db executeUpdate:sql_block];
                if (callback) {
                    callback(bRet);
                }
            }else{
                GKLogSP(@"执行语句%@时,打开数据库失败",sql_block);
                if (callback) {
                    callback(NO);
                }
            }
            [db close];
        }];
    });
}

- (void)multiThreadExecuteQuery:(NSString *)sql callback:(void (^)(id data))callback {
    FMDatabaseQueue * queue_DB = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    dispatch_queue_t queue_t = dispatch_queue_create("multiThreadExecuteQuery", NULL);
    __block NSString * sql_block = sql;
    dispatch_async(queue_t, ^{
        [queue_DB inDatabase:^(FMDatabase *db) {
            BOOL isOPen = [db open];
            if (isOPen) {
                GKLogSP(@"执行查询语句%@时,打开数据库成功",sql_block);
                FMResultSet * rs = [db executeQuery:sql_block];
                if (callback) {
                    callback(rs);
                }
            }else{
                GKLogSP(@"执行查询语句%@时,打开数据库失败",sql_block);
                if (callback) {
                    callback(nil);
                }
            }
            [db close];
        }];
    });
}

- (BOOL)dropDB {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    NSError *error;
    // delete the old db.
    if ([fileManager fileExistsAtPath:dataBasePath])
    {
        [DB close];
        success = [fileManager removeItemAtPath:dataBasePath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }
    return success;
}

@end

//
//  GKDiscoveryViewController.m
//  GKDS_App
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDiscoveryViewController.h"
#import "GKNavigationControllerCommand.h"
#import "PPClient.h"
#import "FMDB.h"
#import "GKDataBaseProxy.h"


#define MOCKSDBNAME    @"mocks.db"

#define t_OnlineMock @"t_OnlineMock"
#define t_OfflineMock @"t_OfflineMock"
#define ID @"id"
#define SubjectId @"SubjectId"
#define JsonModel @"JsonModel"
#define RandomNumber_ arc4random_uniform(100)
@interface GKDiscoveryViewController ()

@end

@implementation GKDiscoveryViewController {
    FMDatabase * _mpDataBase;
    NSString * dataPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documents = [paths firstObject];
    dataPath = [documents stringByAppendingPathComponent:MOCKSDBNAME];
    _mpDataBase = [FMDatabase databaseWithPath:dataPath];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -- 点击事件
- (IBAction)onNext:(id)sender {
    [PPCLIENT sendNotification:kGKNavigationControllerCommand];
}

- (IBAction)onCreate:(id)sender {
     NSString * sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ INTEGER, %@ TEXT)",t_OnlineMock,ID,SubjectId,JsonModel];
//    [GK_DB_PROXY executeUpdate:sqlCreateTable];
    [GK_DB_PROXY multiThreadExecuteUpdate:sqlCreateTable callback:^(BOOL successed) {
        if (!successed) {
            GKLogEX(@"error when creating %@ %@",MOCKSDBNAME,t_OnlineMock);
        } else {
            GKLogEX(@"success when creating %@ %@",MOCKSDBNAME,t_OnlineMock);
        }
    }];
//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        //CREATE TABLE IF NOT EXISTS 't_OnlineMock' ('id' INTEGER PRIMARY KEY AUTOINCREMENT,'SubjectId' INTEGER,'JsonModel' TEXT)
//        NSString * sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ INTEGER, %@ TEXT)",t_OnlineMock,ID,SubjectId,JsonModel];
//        BOOL bVlaue = [_mpDataBase executeUpdate:sqlCreateTable];
//        if (!bVlaue) {
//            GKLogEX(@"error when creating %@ %@",MOCKSDBNAME,t_OnlineMock);
//        } else {
//            GKLogEX(@"success when creating %@ %@",MOCKSDBNAME,t_OnlineMock);
//        }
//        [_mpDataBase close];
//    }
}

- (IBAction)onInsert:(id)sender {
//    --insert into t_OnlineMock (SubjectId,JsonModel) values (20160431, 'HelloWorld1')
    for (int i = 0; i < 10; i++) {
        NSInteger number = 10086;
        NSString * sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES (%ld, '%@')",t_OnlineMock,SubjectId,JsonModel,(long)number,RandomData];
        [GK_DB_PROXY multiThreadExecuteUpdate:sqlInsert callback:^(BOOL successed) {
            if (!successed) {
                GKLogEX(@"error when insert %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
            } else {
                GKLogEX(@"success when insert %@ %@",MOCKSDBNAME,t_OnlineMock);
            }
        }];
    }

//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        for (int i = 0; i < 10; i++) {
//            NSInteger number = RandomNumber_;
//            NSString * sqlInsert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES (%ld, '%@')",t_OnlineMock,SubjectId,JsonModel,(long)number,RandomData];
//            BOOL bValue = [_mpDataBase executeUpdate:sqlInsert];
//            if (!bValue) {
//                GKLogEX(@"error when insert %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
//            }else{
//                GKLogEX(@"success when insert %@ %@",MOCKSDBNAME,t_OnlineMock);
//            }
//        }
//        [_mpDataBase close];
//    }
}

- (IBAction)onDelete:(id)sender {
//    --DELETE from t_OnlineMock where SubjectId = 20160435
    NSInteger number = 1086;
    NSString * sqlDelete = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %ld",t_OnlineMock,SubjectId,(long)number];
    [GK_DB_PROXY multiThreadExecuteUpdate:sqlDelete callback:^(BOOL successed) {
        if (!successed) {
            GKLogEX(@"error when DELETE %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
        } else {
            GKLogEX(@"success when DELETE %@ %@",MOCKSDBNAME,t_OnlineMock);
        }
    }];
//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        NSInteger number = RandomNumber_;
//        NSString * sqlDelete = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %ld",t_OnlineMock,SubjectId,(long)number];
//        BOOL bValue = [_mpDataBase executeUpdate:sqlDelete];
//        if (!bValue) {
//            GKLogEX(@"error when DELETE %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
//        }else{
//            GKLogEX(@"success when DELETE %@ %@",MOCKSDBNAME,t_OnlineMock);
//        }
//        [_mpDataBase close];
//    }
}

- (IBAction)onUpdate:(id)sender {
//    --update t_OnlineMock set SubjectId = 20160431 where JsonModel = 'HelloWorld1'
    NSInteger number = 1086;
    NSString * sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = %ld",t_OnlineMock,JsonModel,RandomData,SubjectId,(long)number];
    [GK_DB_PROXY multiThreadExecuteUpdate:sqlUpdate callback:^(BOOL successed) {
        if (!successed) {
            GKLogEX(@"error when update %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
        } else {
            GKLogEX(@"success when update %@ %@",MOCKSDBNAME,t_OnlineMock);
        }
    }];
//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        NSInteger number = RandomNumber_;
//        NSString * sqlUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = %ld",t_OnlineMock,JsonModel,RandomData,SubjectId,(long)number];
//        BOOL bValue = [_mpDataBase executeUpdate:sqlUpdate];
//        if (!bValue) {
//            GKLogEX(@"error when update %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
//        }else{
//            GKLogEX(@"success when update %@ %@",MOCKSDBNAME,t_OnlineMock);
//        }
//        [_mpDataBase close];
//    }
}

- (IBAction)onSelect:(id)sender {
//      --select * from t_OnlineMock where SubjectId = 20160431
    
    NSInteger number = 1086;
    NSString * sqlSelect = [NSString stringWithFormat:@"SELECT * FROM  %@ WHERE %@ = %ld",t_OnlineMock,SubjectId,(long)number];
    [GK_DB_PROXY multiThreadExecuteQuery:sqlSelect callback:^(id data) {
        if (data) {
            FMResultSet * rs = data;
            NSInteger count = rs.columnNameToIndexMap.count;
            if (count <= 0) {
                GKLogSP(@"没有查到 subjectId = %ld 的数据",(long)number);
            }else{
                while ([rs next]) {
                    int Id = [rs intForColumn:ID];
                    NSString * subjectId = [rs stringForColumn:SubjectId];
                    NSString * jsonModel = [rs stringForColumn:JsonModel];
                    NSLog(@"id = %d, subjectId = %@, jsonModel = %@", Id, subjectId, jsonModel);
                }
            }
        }else{
            GKLogSP(@"没有查到 subjectId = %ld 的数据",(long)number);
        }
    }];
//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        NSInteger number = RandomNumber_;
//        NSString * sqlSelect = [NSString stringWithFormat:@"SELECT * FROM  %@ WHERE %@ = %ld",t_OnlineMock,SubjectId,(long)number];
//        FMResultSet * rs = [_mpDataBase executeQuery:sqlSelect];
//        while ([rs next]) {
//            int Id = [rs intForColumn:ID];
//            NSString * subjectId = [rs stringForColumn:SubjectId];
//            NSString * jsonModel = [rs stringForColumn:JsonModel];
//            NSLog(@"id = %d, subjectId = %@, jsonModel = %@", Id, subjectId, jsonModel);
//        }
//        NSInteger count = rs.columnNameToIndexMap.count;
//        if (count <= 0) {
//            GKLogSP(@"没有查到 subjectId = %ld 的数据",(long)number);
//        }
//        [_mpDataBase close];
//    }

}

- (IBAction)onDrop:(id)sender {
//    --drop table t_OfflineMock
    NSString * sqlDrop = [NSString stringWithFormat:@"DROP TABLE %@",t_OnlineMock];
    [GK_DB_PROXY multiThreadExecuteUpdate:sqlDrop callback:^(BOOL successed) {
        if (!successed) {
            GKLogEX(@"error when drop %@ %@",MOCKSDBNAME,t_OnlineMock);
        }else{
            GKLogEX(@"success when drop %@ %@",MOCKSDBNAME,t_OnlineMock);
        }
    }];
    
    [GK_DB_PROXY dropDB];
//    BOOL openDB = [_mpDataBase open];
//    if (openDB) {
//        //insert into t_OnlineMock (SubjectId,JsonModel) values (20160431, 'HelloWorld1')
//        NSString * sqlDrop = [NSString stringWithFormat:@"DROP TABLE %@",t_OnlineMock];
//        BOOL bValue = [_mpDataBase executeUpdate:sqlDrop];
//        if (!bValue) {
//            GKLogEX(@"error when drop %@ %@",MOCKSDBNAME,t_OnlineMock);
//        }else{
//            GKLogEX(@"success when drop %@ %@",MOCKSDBNAME,t_OnlineMock);
//        }
//        [_mpDataBase close];
//    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    NSError *error;
    // delete the old db.
    if ([fileManager fileExistsAtPath:dataPath])
    {
        [_mpDataBase close];
        success = [fileManager removeItemAtPath:dataPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }

}

- (IBAction)onMultiThread:(id)sender {
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:dataPath];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    [self onCreate:nil];
    
    dispatch_async(q1, ^{
        for (int i = 0; i < 5; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                [db2 open];
                NSInteger number = RandomNumber_;
                NSString * insertSql1 = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES (%ld, '%@')",t_OnlineMock,SubjectId,JsonModel,(long)number,RandomData];
                
                BOOL res = [db2 executeUpdate:insertSql1];
                if (!res) {
                    GKLogEX(@"error when insert %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
                }else{
                    GKLogEX(@"success when insert %@ %@",MOCKSDBNAME,t_OnlineMock);
                }
                [db2 close];
            }];
        }
    });
    
    dispatch_async(q2, ^{
        for (int i = 0; i < 5; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                [db2 open];
                NSInteger number = RandomNumber_;
                NSString * insertSql1 = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES (%ld, '%@')",t_OnlineMock,SubjectId,JsonModel,(long)number,RandomData];
                
                BOOL res = [db2 executeUpdate:insertSql1];
                if (!res) {
                    GKLogEX(@"error when insert %@ %@ SubjectId = %ld",MOCKSDBNAME,t_OnlineMock,(long)number);
                }else{
                    GKLogEX(@"success when insert %@ %@",MOCKSDBNAME,t_OnlineMock);
                }
                [db2 close];
            }];
        }
    });

}



@end

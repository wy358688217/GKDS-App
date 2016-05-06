//
//  GKDataBaseProxy.h
//  GKDS_App
//
//  Created by wang on 16/5/1.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Proxy.h"
#import "PPClient.h"
#define kGKDataBaseProxy @"GKDataBaseProxy"
#define GK_DB_PROXY ((GKDataBaseProxy*)PPCLIENT_PROXY(kGKDataBaseProxy))
@interface GKDataBaseProxy : Proxy
- (BOOL)openDB;
- (BOOL)closeDB;
- (BOOL)dropDB;
- (BOOL)executeUpdate:(NSString *)sql;
- (id)executeQuery:(NSString *)sql;
- (void)multiThreadExecuteUpdate:(NSString *)sql callback:(void (^)(BOOL successed))callback;
- (void)multiThreadExecuteQuery:(NSString *)sql callback:(void (^)(id data))callback;
@end

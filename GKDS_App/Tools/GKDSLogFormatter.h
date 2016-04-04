//
//  GKDSLogFormatter.h
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SafeSingleton.h"

#define GKLOG_OBJ_FlUSH(str) ([GKLogUtils write:str])

@interface GKDSLogFormatter : NSObject<DDLogFormatter>
HMSingletonH(GKDSLogFormatter)
- (void)initDDLog;
@end

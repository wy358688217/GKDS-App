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
@interface GKSystemProxy : Proxy
- (BOOL)curNetEnvironment;
@end

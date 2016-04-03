//
//  GKLoginProxy.h
//  GKDS_App
//
//  Created by wang on 16/3/23.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Proxy.h"
#import "PPClient.h"


#define kGKLoginProxy @"kGKLoginProxy"
#define GK_LOGIN_PROXY ((kGKLoginProxy*)PPCLIENT_PROXY(kGKLoginProxy))
@interface GKLoginProxy : Proxy

@end

//
//  GKSystemProxy.m
//  GKDS_App
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKSystemProxy.h"

@implementation GKSystemProxy {
    BOOL isPublicNet;
}

- (void)initializeProxy {
    isPublicNet = NO;
}

- (BOOL)curNetEnvironment {
    return isPublicNet;
}

@end

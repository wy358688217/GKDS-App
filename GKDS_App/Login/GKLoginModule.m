//
//  GKLoginModule.m
//  GKDS_App
//
//  Created by wang on 16/3/23.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKLoginModule.h"
#import "GKLoginMediator.h"
#import "GKLoginProxy.h"

@implementation GKLoginModule

- (void)onRegister {
    [self registerProxy:[GKLoginProxy withProxyName:kGKLoginProxy]];
    [self registerMediator:[GKLoginMediator withMediatorName:[GKLoginMediator NAME]]];
}

- (void)onRemove {
    [self removeAllProxy];
    [self removeAllMediator];
}

@end

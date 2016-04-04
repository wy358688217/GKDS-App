//
//  GKMainTabModule.m
//  GKDS_App
//
//  Created by wang on 16/3/23.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKMainTabModule.h"
#import "GKNavigationControllerProxy.h"
#import "GKNavigationControllerMediator.h"
#import "GKNavigationControllerCommand.h"
#import "GKUITabBarMediator.h"

@implementation GKMainTabModule

- (void)onRegister {
    [self registerProxy:[GKNavigationControllerProxy withProxyName:kGKNavigationControllerProxy]];
    [self registerMediator:[GKUITabBarMediator withMediatorName:[GKUITabBarMediator NAME]]];
    [self registerMediator:[GKNavigationControllerMediator withMediatorName:[GKNavigationControllerMediator NAME]]];
    [self registerCommand:kGKNavigationControllerCommand withCommand:[GKNavigationControllerCommand class]];
}

- (void)onRemove {
    [self removeAllProxy];
    [self removeAllMediator];
    [self removeAllCommand];
}

@end

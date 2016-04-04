//
//  PPModule.m
//  GKDS_App
//
//  Created by wang on 15/8/6.
//
//

#import "PPModule.h"
#import "GKLoginModule.h"
#import "GKMainTabModule.h"
#import "GKSystemModule.h"
@implementation PPModule

-(void)onRegisterAllModules
{
    [self addModuleOnce:[[GKSystemModule alloc]init]];
    [self addModuleOnce:[[GKLoginModule alloc]init]];
    [self addModuleOnce:[[GKMainTabModule alloc]init]];
}

-(void)onRemoveAllModules
{
    [self removeModule:[GKSystemModule moduleName]];
    [self removeModule:[GKLoginModule moduleName]];
    [self removeModule:[GKMainTabModule moduleName]];
}

@end

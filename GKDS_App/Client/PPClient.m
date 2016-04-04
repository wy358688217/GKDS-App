//
//  PPClient.m
//  GKDS_App
//
//  Created by wang on 15/3/20.
//
//

#import "PPClient.h"

static PPClient* _instance = nil;

@implementation PPClient : Facade

HMSingletonM(PPClient)

-(id)init;
{
    id ret = [super init];
    return ret;
}


-(void)initializeController
{
    [super initializeController];
}

-(void)initializeView
{
    [super initializeView];
}

-(void)initializeModel
{
    [super initializeModel];
}

@end

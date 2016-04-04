//
//  Module.m
//  fTalk
//
//  Created by admin on 15/7/22.
//
//

#import "Module.h"
#import "PPClient.h"

@implementation Module
{
    NSMutableArray *m_vecMediatorName;//UI的集合
    NSMutableArray *m_vecCommandName;//command的集合
    NSMutableArray *m_vecProxyName;//proxy的集合
}

-(id)init{
    if (self = [super init]) {
        m_vecMediatorName = [NSMutableArray array];
        m_vecCommandName = [NSMutableArray array];
        m_vecProxyName = [NSMutableArray array];
    }
    return self;
}

-(void)dealloc {
    if (m_vecProxyName.count > 0) {
        [self removeAllProxy];
    }
    if (m_vecCommandName.count > 0) {
        [self removeAllCommand];
    }
    if (m_vecMediatorName.count > 0) {
        [self removeAllMediator];
    }
    m_vecMediatorName = nil;
    m_vecCommandName = nil;
    m_vecProxyName = nil;
}

+(NSString*)moduleName
{
    return NSStringFromClass([self class]);
}

-(void)onRegister
{
    // subclass will override
}

-(void)onRemove
{
    // subclass will override
}

-(void)registerMediator:(id<IMediator>)mediator {
    [m_vecMediatorName addObject:mediator.mediatorName];
    [PPCLIENT registerMediator:mediator];
}

-(void)registerCommand:(NSString*)name withCommand:(Class)cmdClass {
    [m_vecCommandName addObject:name];
    [PPCLIENT registerCommand:name commandClassRef:cmdClass];
}

-(void)registerProxy:(id<IProxy>)proxy {
    [m_vecProxyName addObject:proxy.proxyName];
    [PPCLIENT registerProxy:proxy];
}

-(void) removeAllMediator
{
    for(NSString * name in m_vecMediatorName)
    {
        [PPCLIENT removeMediator:name];
    }
    [m_vecMediatorName removeAllObjects];
}

-(void) removeAllCommand
{
    for(NSString * name in m_vecCommandName)
    {
        [PPCLIENT removeCommand:name];
    }
    [m_vecCommandName removeAllObjects];
}

-(void) removeAllProxy
{
    for(NSString * name in m_vecProxyName)
    {
        [PPCLIENT removeProxy:name];
    }
    [m_vecProxyName removeAllObjects];
}

@end


//
//  CModuleManager.m
//  fTalk
//
//  Created by zhukeke on 15/7/22.
//
//
#import "ModuleManager.h"
#import "Module.h"

@implementation ModuleManager
{
    BOOL _mbRegistered;
    NSMutableDictionary *m_vecModuleMap;//模块的集合
}

static ModuleManager * sharedInstance = nil;

//获取单例
+(instancetype)getInstance
{
    @synchronized(self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

//唯一一次alloc单例，之后均返回nil
+ (id)alloc
{
    @synchronized([ModuleManager class]) {
        if (sharedInstance == nil) {
            sharedInstance = [super alloc];
            return sharedInstance;
        }
    }
    return nil;
}

-(id)init;
{
    id ret = [super init];
    if (ret) {
        m_vecModuleMap = [NSMutableDictionary dictionaryWithCapacity:64];
    }
    return ret;
}

- (void)dealloc
{
    if (m_vecModuleMap.count > 0) {
        [self removeAll];
    }
    m_vecModuleMap = nil;
}

//添加模块
-(void)addModule:(Module *)module
{
    NSString *key = [module.class moduleName];
    PPAssert([m_vecModuleMap objectForKey:key]==nil,@"addModule 重复添加!");
    [m_vecModuleMap setObject:module forKey:key];
    [module onRegister];
}

-(void)addModuleOnce:(Module*)module
{
    if ([m_vecModuleMap objectForKey:[module.class moduleName]]==nil) {
        [self addModule:module];
    }
}

//移除模块
-(void)removeModule:(NSString *)name
{
    Module* module = [m_vecModuleMap objectForKey:name];
    if (module != nil) {
        [m_vecModuleMap removeObjectForKey:name];
        [module onRemove];
    }
}

//移除所有模块
-(void)removeAll
{
    for (id akey in [m_vecModuleMap allKeys]) {
        Module *module= (Module*)[m_vecModuleMap objectForKey:akey];
        [module onRemove];
    }
    [m_vecModuleMap removeAllObjects];
}

//获取所有模块的数量
-(NSUInteger)getNumOfModule
{
    return [m_vecModuleMap count];
}

-(Module*)getModule:(NSString*)moduleName
{
    Module* module = [m_vecModuleMap objectForKey:moduleName];
    return module;
}

-(void)registerAllModules
{
    if (_mbRegistered==YES) {
        return;
    }
    _mbRegistered = YES;
    [self onRegisterAllModules];
}

-(void)removeAllModules
{
    if (_mbRegistered==NO) {
        return;
    }
    _mbRegistered = NO;
    [self onRemoveAllModules];
}

-(void)onRegisterAllModules
{
    // subclass will override
}

-(void)onRemoveAllModules
{
    // subclass will override
}

@end
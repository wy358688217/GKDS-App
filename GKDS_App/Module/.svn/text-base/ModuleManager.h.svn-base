
//
//  CModuleManager.h
//  fTalk
//
//  Created by admin on 15/7/22.
//
//

#ifndef fTalk_CModuleManager_h
#define fTalk_CModuleManager_h

#import <Foundation/Foundation.h>

@protocol ModuleManagerProtocol <NSObject>
-(void)onRegisterAllModules;
-(void)onRemoveAllModules;
-(void)registerAllModules;
-(void)removeAllModules;
@end

@class Module;
@interface ModuleManager : NSObject <ModuleManagerProtocol>
+(instancetype)getInstance;
-(void)addModule:(Module*)module;
-(void)addModuleOnce:(Module*)module; // 保证只会添加一次
-(void)removeModule:(NSString*)name;
-(void)removeAll;
-(NSUInteger)getNumOfModule;
-(Module*)getModule:(NSString*)moduleName;
@end

#endif

//
//  Module.h
//  fTalk
//
//  Created by admin on 15/7/22.
//
//

#ifndef __KK_MODULE_H__
#define __KK_MODULE_H__

#import <Foundation/Foundation.h>
#import "IMediator.h"
#import "IProxy.h"
#import "ICommand.h"

@protocol ModuleProtocol <NSObject>
-(void)onRegister;//注册
-(void)onRemove;//解注册
@end

@interface Module : NSObject <ModuleProtocol>
+(NSString*)moduleName;
-(void)registerProxy:(id<IProxy>)proxy;
-(void)registerMediator:(id<IMediator>)mediator;
-(void)registerCommand:(NSString*)name withCommand:(Class)cmdClass;
-(void)removeAllMediator;
-(void)removeAllCommand;
-(void)removeAllProxy;
@end

#endif

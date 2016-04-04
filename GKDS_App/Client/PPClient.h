//
//  PPClient.h
//  GKDS_App
//  代码作者: wang
//  文件说明: MVC - 系统外观
//  Created by wang on 15/3/20.
//
//

#ifndef __PP_CLIENT_H__
#define __PP_CLIENT_H__

#import "Facade.h"
#import "Observer.h"
#import "SafeSingleton.h"

@interface PPClient : Facade
HMSingletonH(PPClient)
-(void)initializeController;
-(void)initializeView;
-(void)initializeModel;
@end

#define PPCLIENT ((PPClient*)[PPClient getInstance])
#define PPCLIENT_REGISTER_OBSERVER(NAME, SEL, OBJCET) [PPCLIENT.view registerObserver:NAME observer:[Observer withNotifyMethod:SEL notifyContext:OBJCET]]
#define PPCLIENT_UNREGISTER_OBSERVER(NAME, OBJECT) [PPCLIENT.view removeObserver:NAME notifyContext:OBJECT]
#define PPCLIENT_PROXY(key) [PPCLIENT retrieveProxy:key]
#define PPCLIENT_MEDIATOR(key) [PPCLIENT retrieveMediator:key]

#endif

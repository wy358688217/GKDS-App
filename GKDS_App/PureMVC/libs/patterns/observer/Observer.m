//
//  Observer.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Observer.h"
#import <objc/message.h>

@implementation Observer

@synthesize notifyMethod, notifyContext;

/**
 * Static Convienence Constructor.
 */
+(id)withNotifyMethod:(SEL)notifyMethod notifyContext:(id)notifyContext {
    //原始MRC版本
	//return [[[self alloc] initWithNotifyMethod:notifyMethod notifyContext:notifyContext] autorelease];
    //修改为ARC版本
    return [[self alloc] initWithNotifyMethod:notifyMethod notifyContext:notifyContext];
}

/**
 * Constructor. 
 * 
 * <P>
 * The notification method on the interested object should take 
 * one parameter of type <code>INotification</code></P>
 * 
 * @param notifyMethod the notification method of the interested object
 * @param notifyContext the notification context of the interested object
 */
-(id)initWithNotifyMethod:(SEL)_notifyMethod notifyContext:(id)_notifyContext {
	if (self = [super init]) {
		self.notifyMethod = _notifyMethod;
		self.notifyContext = _notifyContext;
	}
	return self;
}

/**
 * Compare an object to the notification context. 
 * 
 * @param object the object to compare
 * @return boolean indicating if the object and the notification context are the same
 */
-(BOOL)compareNotifyContext:(id)object {
	return [object isEqual:notifyContext];
}

/**
 * Notify the interested object.
 * 
 * @param notification the <code>INotification</code> to pass to the interested object's notification method.
 */
-(void)notifyObserver:(id<INotification>)notification {
    //原始版本 有⚠️
//	[notifyContext performSelector:notifyMethod withObject:notification];
    
    //由wang修改 解除⚠️ 出现too many argument error 时 修改 Enable Strict Checking of objc_msgSend Calls 为 NO
    objc_msgSend(notifyContext,notifyMethod,notification);
}

-(void)dealloc {
	self.notifyMethod = nil;
	self.notifyContext = nil;
	//[super dealloc];//MRC版本
}


@end

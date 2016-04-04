//
//  Proxy.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "Proxy.h"

@implementation Proxy

@synthesize data, proxyName;

+(id)proxy {
    //原始版本
    //return [[[self alloc] initWithProxyName:nil data:nil] autorelease];
    //原始版本
    return [[self alloc] initWithProxyName:nil data:nil];
}

+(id)withProxyName:(NSString *)proxyName {
    //原始版本
    //return [[[self alloc] initWithProxyName:proxyName data:nil] autorelease];
    //原始版本
    return [[self alloc] initWithProxyName:proxyName data:nil];
}

+(id)withProxyName:(NSString *)proxyName data:(id)data {
    //原始版本
    //return [[[self alloc] initWithProxyName:proxyName data:data] autorelease];
    //原始版本
    return [[self alloc] initWithProxyName:proxyName data:data];
}

+(id)withData:(id)data {
    //原始版本
    //return [[[self alloc] initWithProxyName:nil data:data] autorelease];
    //原始版本
    return [[self alloc] initWithProxyName:nil data:data];
}

-(id)initWithProxyName:(NSString *)_proxyName data:(id)_data {
	if (self = [super init]) {
		self.proxyName = (_proxyName == nil) ? [[self class] NAME] : _proxyName;
		self.data = _data;
		[self initializeProxy];
	}
	return self;
}

+(NSString *)NAME {
	return @"Proxy";
}

/**
 * Initialize the Proxy instance.
 * 
 * <P>
 * Called automatically by the constructor, this
 * is your opportunity to initialize the Proxy
 * instance in your subclass without overriding the
 * constructor.</P>
 * 
 * @return void
 */
-(void)initializeProxy {}

/**
 * Called by the Model when the Proxy is registered
 */ 
-(void)onRegister {}

/**
 * Called by the Model when the Proxy is removed
 */ 
-(void)onRemove {}

-(void)dealloc {
	self.data = nil;
	self.proxyName = nil;
	//[super dealloc];
}

@end

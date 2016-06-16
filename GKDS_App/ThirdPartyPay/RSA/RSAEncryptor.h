//
//  RSAEncryptor.h
//  GKDS_App
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject



#pragma mark - Instance Methods

- (void)loadPublicKeyFromFile: (NSString*) derFilePath;
- (void)loadPublicKeyFromData: (NSData*) derData;

- (void)loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
- (void)loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;




- (NSString*)rsaEncryptString:(NSString*)string;
- (NSData*)rsaEncryptData:(NSData*)data ;

- (NSString*)rsaDecryptString:(NSString*)string;
- (NSData*)rsaDecryptData:(NSData*)data;

- (NSString*)rsaDecryptLongString:(NSString*)string;
- (NSData *)rsaDecryptLongData:(NSData *)data;

- (BOOL) rsaSHA1VerifyData:(NSData *) plainData
            withSignature:(NSData *) signature;



#pragma mark - Class Methods

+ (void)setSharedInstance: (RSAEncryptor*)instance;
+ (RSAEncryptor*)sharedInstance;
@end
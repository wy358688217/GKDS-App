//
//  GKRSAEncryptor.h
//  GKDS_App
//
//  Created by wang on 16/6/16.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKRSAEncryptor : NSObject
/**
 *  加载公钥通过文件的方式
 *
 *  @param derFilePath 文件的完整路径
 */
- (void)loadPublicKeyFromFile: (NSString*) derFilePath;
/**
 *  加载公钥通过二进制文件
 *
 *  @param derData 二进制文件
 */
- (void)loadPublicKeyFromData: (NSData*) derData;
/**
 *  加载私钥通过文件的方式
 *
 *  @param p12FilePath 私钥完整文件路径
 *  @param p12Password 导入密码
 */
- (void)loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;
/**
 *  加载私钥通过二进制文件
 *
 *  @param p12Data     二进制文件
 *  @param p12Password 导入密码
 */
- (void)loadPrivateKeyFromData: (NSData*) p12Data password:(NSString*)p12Password;
/**
 *  通过字符串加密
 *
 *  @param string 字符串
 *
 *  @return 密文
 */
- (NSString*)rsaEncryptString:(NSString*)string;
/**
 *  通过二进制加密
 *
 *  @param data 二进制文件
 *
 *  @return 密文
 */
- (NSData*)rsaEncryptData:(NSData*)data ;

/**
 *  解密字符串
 *
 *  @param string 密文
 *
 *  @return 明文
 */
- (NSString*)rsaDecryptString:(NSString*)string;
/**
 *  解密二进制
 *
 *  @param data 密文
 *
 *  @return 明文
 */
- (NSData*)rsaDecryptData:(NSData*)data;
/**
 *  验证签名和二进制文件
 *
 *  @param plainData 二进制文件
 *  @param signature 签名
 *
 *  @return 返回布尔值
 */
- (BOOL) rsaSHA1VerifyData:(NSData *)plainData withSignature:(NSData *)signature;
@end
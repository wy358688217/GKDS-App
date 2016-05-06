//
//  GKWeiXinPayViewController.m
//  GKDS_App
//
//  Created by wang on 16/4/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKWeiXinPayViewController.h"
#import "WXApiManager.h"
#import "ALSystem.h"
#import "AFNetworking.h"

@interface GKWeiXinPayViewController ()<WXApiManagerDelegate>

@end

@implementation GKWeiXinPayViewController
- (IBAction)onTestAlertView:(id)sender {
    UIAlertView * tipsView = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"老师下课啦，同学记得巩固复习喔！" delegate:self cancelButtonTitle:@"离开教室" otherButtonTitles:nil];
    [tipsView show];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSDictionary * memoryInfo = [ALSystem memoryInformations];
//    NSDictionary * netWorkInfo = [ALSystem networkInformations];
//    NSDictionary * cpuInfo = [ALSystem processorInformations];
//    GKLog(memoryInfo);
//    GKLog(netWorkInfo);
//    GKLog(cpuInfo);
}

static const NSInteger kRecvGetMessageReqAlertTag = 1000;
#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)req {
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@", req.openID];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    alert.tag = kRecvGetMessageReqAlertTag;
    [alert show];
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", req.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //从微信启动App
    NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", req.openID, msg.messageExt];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", response.errCode];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response {
    NSMutableString* cardStr = [[NSMutableString alloc] init];
    for (WXCardItem* cardItem in response.cardAry) {
        [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%u\n",cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp"
                                                    message:cardStr
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -- 微信支付点击事件
- (IBAction)onWeinPay:(id)sender {
    
    [self requestOrder];
    return;
    NSString *res = [self handle];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
        return;
    
    if (alertView.tag == kRecvGetMessageReqAlertTag) {
        GKLog(@"支付失败");
//        RespForWeChatViewController* controller = [[RespForWeChatViewController alloc]autorelease];
//        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (NSString *)handle {
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://10.10.100.170:8082/gkapp_server/py/data";//@"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSError *error;
        if ( data != nil) {
            NSMutableDictionary *dict = NULL;
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            NSLog(@"url:%@",urlString);
            if(dict != nil){
                NSMutableString *retcode = [dict objectForKey:@"retcode"];
                if (retcode.intValue == 0){
                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                    
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId           = [dict objectForKey:@"partnerid"];
                    req.prepayId            = [dict objectForKey:@"prepayid"];
                    req.nonceStr            = [dict objectForKey:@"noncestr"];
                    req.timeStamp           = stamp.intValue;
                    req.package             = [dict objectForKey:@"package"];
                    req.sign                = [dict objectForKey:@"sign"];
                    [WXApi sendReq:req];
                    //日志输出
                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                    return @"";
                }else{
//                    return [dict objectForKey:@"retmsg"];
                }
            }else{
//                return @"服务器返回错误，未获取到json对象";
            }
        }else{
//            return @"服务器返回错误";
        }
    }];
    return @"";
}

- (NSString *)handlePay:(NSDictionary*)orderDict {
    
    /**
     *  data:数据对象
     orderItems:
     title;标题
     cover;封面地址
     count;订购数
     price;单价
     contact;默认联系方式
     type;条目类型
     typeName;条目类型名称
     totalPrice:总价
     payTypes: 支持的支付渠道1支付宝 2微信 3银联只有渠道支持页面上才能显示并按顺序先后展示
     type:渠道类型
     def:是否默认选中渠道 0否 1是

     */
    NSString *urlString   = @"http://10.10.100.170:8082/gkapp_server/py/data";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"contact"] = @"2331570398";
//    params[@"payType"] = @(2);
//    params[@"grant_type"] = @"authorization_code";
//    params[@"redirect_uri"] = @"http://";
//    params[@"code"] = code;
    return @"";
}

- (void)requestOrder {
    
    
    [self test];
    return;
    // order/items
    WEAK_BLOCK_OBJECT(self);
    NSString *urlString   = @"http://10.10.100.170:8082/gkapp_server/order/items";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableArray *params = [NSMutableArray array];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"itemId"] = @(1);
    dict[@"itemType"] = @(2);
    dict[@"itemCount"] = @(1);
    [params addObject:dict];
    
//    NSString * items = [self.class objectConvertJson:params];
    [manager GET:urlString parameters:@{ @"data" : params } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_OBJECT(self);
        
        NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary * itemDict = dic[@"data"];
//        NSString * title = itemDict[@"title"];
        [weak_self handlePay:dic];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求订单失败");
    }];
    
}


- (void)test{
    NSString * url = @"http://file.ifreetalk.com/config/ios";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray<NSDictionary *> * array = (NSArray*)dic[@"array"];
        NSMutableArray * mutableDataArray = [[NSMutableArray alloc]initWithCapacity:array.count];
        
        [[NSUserDefaults standardUserDefaults] setObject:mutableDataArray forKey:@"mutableDataArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

+(NSString*)objectConvertJson:(id)obj
{
    NSError * error = nil;
    // Pass 0 if you don't care about the readability of the generated string
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&error];
    if (error) {
        GKLogSP(@"%@",error);
        return @"{}";
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  data:数据对象
	orderItems:
 title;标题
 cover;封面地址
 count;订购数
 price;单价
 contact;默认联系方式
 type;条目类型
 typeName;条目类型名称
	totalPrice:总价
 payTypes: 支持的支付渠道1支付宝 2微信 3银联只有渠道支持页面上才能显示并按顺序先后展示
 type:渠道类型
 def:是否默认选中渠道 0否 1是

 */
@end


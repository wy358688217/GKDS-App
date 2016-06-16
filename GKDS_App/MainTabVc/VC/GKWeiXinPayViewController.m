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
#import "RSAEncryptor.h"

@interface GKWeiXinPayViewController ()<WXApiManagerDelegate>

@end

@implementation GKWeiXinPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString * json = @"{'respCode':'000','respDesc':'成功','cacheToken':'','data':{'baseKvUrl':'http://7xk1xm.com1.z0.glb.clouddn.com/@','kvAdList':[{'imagePath':'/kvImage/2016051624020456_96.jpg','linkUrl':'川藏线','cmd':'http://openbrowser|http://www.baidu.com','kvAdId':71,'title':'测试而已- -'},{'imagePath':'/kvImage/2016042924021456_49.jpg','linkUrl':'www.guokaodashi.com','cmd':'http://open|www.guokaodashi.com','kvAdId':69,'title':'测试跳转到外部链接'},{'imagePath':'/kvImage/2016042924100029_2.jpg','linkUrl':'www.guokaodashi.com','cmd':'http://live_personal_lessons|2','kvAdId':67,'title':'11223344'},{'imagePath':'/kvImage/2016030724093903_66.jpg','linkUrl':'http://system.guokaodashi.com/static/cmd.html','cmd':'http://onlie_exam_info|12','kvAdId':60,'title':'测试获取用户信息命令'},{'imagePath':'/kvImage/2016030724093903_66.jpg','linkUrl':'http://system.guokaodashi.com/liveCourse/list','cmd':'http://open|http://system.guokaodashi.com/liveCourse/list?fromApp=1','kvAdId':61,'title':'测试课程购买'}],'recommendNewsColumnList':[{'newsTypeId':2,'newsName':'申论论点'},{'newsTypeId':1,'newsName':'时政热点'}],'recommendNewsList':[{'newsId':3923,'imagePath':'http://7xk1xm.com1.z0.glb.clouddn.com/@//newsImage/newsIcon/2016051024012238_0.jpg','newsTypeTitle':'狮笑世事','title':'你所期待的夏天是什么样子的？','createTime':'2015-12-28 14:04:03','commentCount':4},{'newsId':3860,'imagePath':'http://7xk1xm.com1.z0.glb.clouddn.com/@/newsImage/newsIcon/2016012724041227_55.png','newsTypeTitle':'狮笑世事','title':'我的人生我做主','createTime':'2016-02-29 17:41:14','commentCount':0},{'newsId':3940,'imagePath':'http://7xk1xm.com1.z0.glb.clouddn.com/@/newsImage/newsIcon/2016052524023126_74.png','newsTypeTitle':'申论论点','title':'ceshi环境123','createTime':null,'commentCount':5},{'newsId':3906,'imagePath':null,'newsTypeTitle':'狮笑世事','title':'高考后的那些事儿','createTime':null,'commentCount':18},{'newsId':3905,'imagePath':'http://7xk1xm.com1.z0.glb.clouddn.com/@/newsImage/newsIcon/2015061124030800.jpg','newsTypeTitle':'来稿惊喜','title':'《国考志》征稿启事','createTime':null,'commentCount':3}],'recommendShowVideoList':[{'videoId':10,'videoTitle':'频道视频10','videoScreenshot':'http://www.suqian.gov.cn/publishfile/1251900553654.jpg','playCount':305,'commentCount':0,'evaluate':0.0,'videoIntro':null,'duration':1210,'voteCount':0,'shareUrl':null,'playObjectList':null},{'videoId':10,'videoTitle':'频道视频10','videoScreenshot':'http://www.suqian.gov.cn/publishfile/1251900553654.jpg','playCount':305,'commentCount':0,'evaluate':0.0,'videoIntro':null,'duration':1210,'voteCount':0,'shareUrl':null,'playObjectList':null},{'videoId':19,'videoTitle':'呵呵哒哒哒爱的','videoScreenshot':'http://7xk1xm.com1.z0.glb.clouddn.com/@/video/videoIcon/2016030424025026_72.png','playCount':271,'commentCount':0,'evaluate':0.0,'videoIntro':null,'duration':2313,'voteCount':0,'shareUrl':null,'playObjectList':null},{'videoId':8,'videoTitle':'频道视频8','videoScreenshot':'http://www.suqian.gov.cn/publishfile/1251900553654.jpg','playCount':212,'commentCount':0,'evaluate':0.0,'videoIntro':null,'duration':1238,'voteCount':0,'shareUrl':null,'playObjectList':null},{'videoId':5,'videoTitle':'频道视频5','videoScreenshot':'http://www.suqian.gov.cn/publishfile/1251900553654.jpg','playCount':340,'commentCount':0,'evaluate':0.0,'videoIntro':null,'duration':1235,'voteCount':0,'shareUrl':null,'playObjectList':null}],'channelId':1},'success':true}";
    NSString * strppp = @"{'respCode':'000','respDesc':'成功','cacheToken':'','data':{},'success':true}";
    NSString * strdata = @"你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：";/*分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：你阿妈你阿米娜年你阿妈fucvk：：分促进{}：";*/
//    id encryptData = [self encrypt:json];
    NSString * encryptStr = [self encrypToString:json];
    GKLogSP(@"加密后密文:%@",encryptStr);
//    GKLogSP(@"加密后密文:%@",[[NSString alloc]initWithData:encryptData encoding:NSUTF8StringEncoding]);
//    NSString * decryptStr = [self decrypt:encryptData];
    NSString * decryptStr = [self decryptToString:encryptStr];
    GKLogSP(@"解密后明文:%@",decryptStr);
}

- (id)encrypToString:(NSString *)securityText {
    RSAEncryptor * rsa = [[RSAEncryptor alloc] init];
    [RSAEncryptor setSharedInstance:rsa];
    NSLog(@"encryptor using rsa");
    NSString * publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSLog(@"public key: %@", publicKeyPath);
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSString * encryptedString = [rsa rsaEncryptString:securityText];
    return encryptedString;
}

- (id)decryptToString:(NSString *)encryptedString {
    /*- (NSString *)decrypt:(NSString *)tring {*/
    NSLog(@"decryptor using rsa");
    RSAEncryptor * rsa = [[RSAEncryptor alloc] init];
    NSString * privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSLog(@"private key: %@", privateKeyPath);
    [rsa loadPrivateKeyFromFile:privateKeyPath password:@"0012"];
    NSString * decryptedString = [rsa rsaDecryptLongString:encryptedString];
    return decryptedString;
}


- (id)encrypt:(NSString *)securityText {
    NSData * data = [securityText dataUsingEncoding:NSUTF8StringEncoding];
    RSAEncryptor * rsa = [[RSAEncryptor alloc] init];
    [RSAEncryptor setSharedInstance:rsa];
    NSLog(@"encryptor using rsa");
    NSString * publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSLog(@"public key: %@", publicKeyPath);
    [rsa loadPublicKeyFromFile:publicKeyPath];
    NSData * encryptedData = [rsa rsaEncryptData:data];
    return encryptedData;
}
- (id)decrypt:(NSData *)data {
    NSLog(@"decryptor using rsa");
    RSAEncryptor * rsa = [[RSAEncryptor alloc] init];
    NSString * privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSLog(@"private key: %@", privateKeyPath);
    [rsa loadPrivateKeyFromFile:privateKeyPath password:@"0012"];
    NSData * decryptedData = [rsa rsaDecryptData:data];
    NSString * decryptedString = [[NSString alloc]initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return decryptedString;
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


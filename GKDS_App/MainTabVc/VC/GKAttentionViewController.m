//
//  GKAttentionViewController.m
//  GKDS_App
//
//  Created by wang on 16/4/9.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKAttentionViewController.h"
#import "GKSystemProxy.h"
#import "PPClient.h"
#import "UIView+Toast.h"
#import "GKNavigationControllerProxy.h"

@interface GKAttentionViewController ()

@end

@implementation GKAttentionViewController {
    NSTimer * networkTimer;
}

- (void)dealloc
{
    [networkTimer invalidate];
    if (networkTimer) {
        networkTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)updateNetSpeed {
    WEAK_BLOCK_OBJECT(self);
    [GK_SYS_PROXY curNetSpeed:^(NSString *downloadSpeed, NSString *uploadSpeed) {
        BLOCK_OBJECT(self);
//        NSString * down = [NSString stringWithFormat:@"当前即时下载速度为:%@",downloadSpeed];
//        NSString * up = [NSString stringWithFormat:@"当前即时上传速度为:%@",uploadSpeed];
        NSString * text = [NSString stringWithFormat:@"实时网速：上行%@ ,下行%@",uploadSpeed,downloadSpeed];
        [weak_self makeToast:text];
        GKLogSP(@"当前即时下载速度为:%@",downloadSpeed);
        GKLogSP(@"当前即时上传速度为:%@",uploadSpeed);
        
    }];
}

- (void)makeToast:(NSString *)text {
    CSToastStyle * style = [[CSToastStyle alloc]initWithDefaultStyle];
    style.messageColor = [UIColor greenColor];
    style.backgroundColor = [UIColor yellowColor];
    [[GK_NAV_PROXY getCurWindow] makeToast:text duration:3.0 position:CSToastPositionBottom style:style];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!networkTimer) {
        networkTimer = [NSTimer scheduledTimerWithTimeInterval:5.f
                                                        target:self
                                                      selector:@selector(updateNetSpeed)
                                                      userInfo:nil
                                                       repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:networkTimer forMode:NSRunLoopCommonModes];
    }
    [networkTimer fire];
    NSString * curNetworkOperators = [GK_SYS_PROXY curNetworkOperators];
    NSString * curClientVersion = [GK_SYS_PROXY curClientVersion];
    NSString * curIOSVersion = [GK_SYS_PROXY curIOSVersion];
    NSString * curNetStatus = [GK_SYS_PROXY curNetStatus];
    GKLog(curNetworkOperators);
    GKLog(curClientVersion);
    GKLog(curNetStatus);
    GKLog(curIOSVersion);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [networkTimer invalidate];
}
- (IBAction)onAddMemory:(id)sender {
    for(int i=0;i<300;i++)
    {
        UILabel*tmpLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,200)];
        tmpLabel.layer.masksToBounds=YES;
        tmpLabel.layer.cornerRadius=10;
        tmpLabel.backgroundColor=[UIColor redColor];
        [self.view addSubview:tmpLabel];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger count = [GK_SYS_PROXY curCPUCount];
        NSString * userStr = [GK_SYS_PROXY curCPUUsageForApp];
        NSString * memorySizeStr = [GK_SYS_PROXY curPhoneMemorySize];
        NSString * userdMemorySizeStr = [GK_SYS_PROXY curMemoryUsageForApp];
        DDLogWarn(@"当前手机CPU数量为：%ld",(long)count);
        DDLogWarn(@"当前App使用CPU百分比为：%@",userStr);
        DDLogWarn(@"当前手机内存总大小为：%@",memorySizeStr);
        DDLogWarn(@"当前App使用内存百分比为：%@",userdMemorySizeStr);
    });



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

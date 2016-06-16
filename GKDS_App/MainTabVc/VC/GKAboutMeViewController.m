//
//  GKAboutMeViewController.m
//  GKDS_App
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKAboutMeViewController.h"
#import "GKNavigationControllerProxy.h"
#import "GKNavigationControllerMediator.h"
#import "UITabBar+GKBadge.h"
#import "GKUITabBarMediator.h"
#import "GKViewControllerDelegate.h"

@interface GKAboutMeViewController ()<GKViewControllerDelegate>

@end

@implementation GKAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //时间提示
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    NSString *confromTimespStr = [formatter stringFromDate:datenow];
//    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    NSArray<NSString *> * array = [confromTimespStr componentsSeparatedByString:@"-"];
    GKLog(array);
    NSString * str = [NSString stringWithFormat:@"%@年%@月%@日 %@时%@分%@秒",array[0],array[1],array[2],array[3],array[4],array[5]];
    GKLog(str);
    GKLogEX(@"%@年%@月%@日 %@时%@分%@秒",array[0],array[1],array[2],array[3],array[4],array[5]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onNext:(id)sender {
    GKUITabBarMediator * mediator = (GKUITabBarMediator *)[PPCLIENT retrieveMediator:NSStringFromClass([GKUITabBarMediator class])];
    [mediator setDelegate:self];
    
    [PPCLIENT sendNotification:kPushToDiscoveryViewController];
    [PPCLIENT sendNotification:kShowTabBarBadgeWithIndex body:@(1) type:IntToSTring(1)];
    [PPCLIENT sendNotification:kShowCurrentTabBarBadge];

}

- (IBAction)onTest:(id)sender {
    [PPCLIENT sendNotification:kHiddenCurrentTabBarBadge];
}


- (IBAction)onCrashOne:(id)sender {
    //演示数组越界崩溃
    NSArray * array = @[@"dasd",@"dasdas"];
    GKLog(array[5]);
}

- (IBAction)onCrashTwo:(id)sender {
    //演示找不到函数
    [self performSelector:@selector(lalla:)];
}

- (IBAction)onCrashThree:(id)sender {
    //演示-键值对引用nil
    [[NSMutableDictionary dictionary]setObject:nil forKey:@"nil"];

}

- (IBAction)onCrashFour:(id)sender {
    //演示memorywarning级别3以上
    [self performSelector:@selector(killMemory)withObject:nil];
}

- (IBAction)onCrashFive:(id)sender {
    
}

-(void)killMemory
{
    for(int i=0;i<300000;i++)
    {
        UILabel*tmpLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,200)];
        tmpLabel.layer.masksToBounds=YES;
        tmpLabel.layer.cornerRadius=10;
        tmpLabel.backgroundColor=[UIColor redColor];
        [self.view addSubview:tmpLabel];
    }
}

#pragma mark -- GKViewControllerDelegate
- (void)changeSubViewsStatus:(id)data {
    GKLog(@"代理回调");
}

@end

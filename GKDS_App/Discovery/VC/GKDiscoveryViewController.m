//
//  GKDiscoveryViewController.m
//  GKDS_App
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKDiscoveryViewController.h"
#import "GKNavigationControllerCommand.h"
#import "PPClient.h"

@interface GKDiscoveryViewController ()

@end

@implementation GKDiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark -- 点击事件
- (IBAction)onNext:(id)sender {
    [PPCLIENT sendNotification:kGKNavigationControllerCommand];
}

@end

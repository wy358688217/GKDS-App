//
//  GKChooseViewController.m
//  GKDS_App
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKChooseViewController.h"
#import "PPClient.h"
#import "GKNavigationControllerProxy.h"
#import "GKRecommendViewController.h"

@interface GKChooseViewController ()

@end

@implementation GKChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择兴趣";
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 点击事件
- (IBAction)onPopRootVc:(id)sender {
    [[GK_NAV_PROXY fetchCurTopViewController].navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onPopNextVc:(id)sender {
    GKRecommendViewController * vc = [[GKRecommendViewController alloc]init];
    [[GK_NAV_PROXY fetchCurTopViewController].navigationController pushViewController:vc animated:YES];
}

@end

//
//  GKRecommendViewController.m
//  GKDS_App
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKRecommendViewController.h"
#import "PPClient.h"
#import "GKNavigationControllerProxy.h"
#import "GKDiscoveryViewController.h"

@interface GKRecommendViewController ()

@end

@implementation GKRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 点击事件

- (IBAction)onPopToDiscoveryVc:(id)sender {
    NSArray * vcArray = self.navigationController.viewControllers;
    for (UIViewController * vc in vcArray) {
        if (IsClassOf(vc, GKDiscoveryViewController)) {
            [[GK_NAV_PROXY fetchCurTopViewController].navigationController popToViewController:vc animated:YES];
        }
    }
}

- (IBAction)onPopRootVc:(id)sender {
    [[GK_NAV_PROXY fetchCurTopViewController].navigationController popToRootViewControllerAnimated:YES];
}
@end

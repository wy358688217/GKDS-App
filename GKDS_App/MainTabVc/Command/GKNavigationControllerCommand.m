//
//  GKNavigationControllerCommand.m
//  GKDS_App
//
//  Created by wang on 16/3/25.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "GKNavigationControllerCommand.h"
#import "GKNavigationControllerProxy.h"
#import "GKChooseViewController.h"

@implementation GKNavigationControllerCommand

- (void)execute:(id<INotification>)notification {
    GKChooseViewController * vc = [[GKChooseViewController alloc]init];
    [[GK_NAV_PROXY fetchCurTopViewController].navigationController pushViewController:vc animated:YES];
}

@end

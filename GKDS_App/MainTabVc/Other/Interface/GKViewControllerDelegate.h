//
//  GKViewControllerDelegate.h
//  GKDS_App
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GKViewControllerDelegate <NSObject>
@optional
- (void)changeSubViewsStatus:(id)data;
@end

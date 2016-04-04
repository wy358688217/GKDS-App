//
//  main.m
//  GKDS_App
//
//  Created by wang on 16/3/22.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKDSAppDelegate.h"
#import "GKLogUtils.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // 将日志文件重定向到ITLog.txt文件中去，方便测试时找bug用
        [GKLogUtils switchStderrToFile];
        DDLogInfo(@"****** GuoKaoDaShi begin ******");
        int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([GKDSAppDelegate class]));
        DDLogInfo(@"****** GuoKaoDaShi end   ******");
        return retVal;
    }
}

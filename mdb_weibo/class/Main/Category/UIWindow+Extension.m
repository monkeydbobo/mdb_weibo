//
//  UIWindow+Extension.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/13.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "mdbTabbarController.h"
#import "NewFeatureViewController.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    NSString *lastVesion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([currentVesion isEqualToString:lastVesion])
    {
        self.rootViewController = [[mdbTabbarController alloc]init];
    }
    else
    {
        //新版本
        self.rootViewController = [[NewFeatureViewController alloc]init];
        //将版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVesion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults ]synchronize];
    }

}
@end

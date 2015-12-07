//
//  AppDelegate.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/4.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "AppDelegate.h"
#import "mdbTabbarController.h"
#import "NewFeatureViewController.h"
#import "oAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
    NSDictionary *account = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (account) {
        //上次使用的沙盒版本号
        NSString *key = @"CFBundleVersion";
        NSString *lastVesion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
        NSString *currentVesion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        if ([currentVesion isEqualToString:lastVesion]) {
            //版本号相同，这次和上次是同一个版本
            self.window.rootViewController = [[mdbTabbarController alloc]init];
            
        }else
        {
            //新版本
            self.window.rootViewController = [[NewFeatureViewController alloc]init];
            
            //将版本号存入沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVesion forKey:@"CFBundleVersion"];
            [[NSUserDefaults standardUserDefaults ]synchronize];
            
        }
    }else{
        self.window.rootViewController = [[oAuthViewController alloc]init];
    }
    
    //显示跟控制器
    [self.window makeKeyAndVisible];
    return YES;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end

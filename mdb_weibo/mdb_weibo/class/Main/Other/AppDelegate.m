//
//  AppDelegate.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/4.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "AppDelegate.h"
#import "oAuthViewController.h"
#import "mdbAccountTools.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    mdbAccount *account =[mdbAccountTools account];
    
    //显示跟控制器
    [self.window makeKeyAndVisible];
    
    if (account)//如果accout存在，已经登录成功过
    {
        [self.window switchRootViewController];
    }
    else
    {
        self.window.rootViewController = [[oAuthViewController alloc]init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
/*
 *app进入后台的时候调用的方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     * app状态
     * 1.死亡状态
     * 2.前台运行状态
     * 3.后台暂停状态:停止一切动画定时器和多媒体操作
     * 4.后台运行状态
     */
    
    // 向操作系统申请后台运行的资格，能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经过期，就会调用这个block
        
        //结束这个任务
        [application endBackgroundTask:task];
    }];
    //搞一个0kb的MP3文件循环播放 
    
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
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //取消下载
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    [mgr cancelAll];
    //清楚内存中的所有图片
    [mgr.imageCache clearMemory];
}
@end

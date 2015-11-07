//
//  AppDelegate.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/4.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "AppDelegate.h"
#import "mdbHomeController.h"
#import "mdbDiscoverController.h"
#import "mdbMessageController.h"
#import "mdbProfileViewController.h"
#import "mdb.pch"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置根控制器
    UITabBarController *tabbarVc = [[UITabBarController alloc]init];
    self.window.rootViewController = tabbarVc;
    [self.window makeKeyAndVisible];
    
    mdbHomeController *home = [[mdbHomeController alloc]init];
    [self addChildVc:home andTitle:@"首页" andImage:@"tabbar_home" andSelected:@"tabbar_home_selected"];
    
    mdbMessageController *message = [[mdbMessageController alloc]init];
    [self addChildVc:message andTitle:@"消息" andImage:@"tabbar_message_center" andSelected:@"tabbar_message_center_selected"];
    
    mdbDiscoverController *discover = [[mdbDiscoverController alloc]init];
    [self addChildVc:discover andTitle:@"搜索" andImage:@"tabbar_discover" andSelected:@"tabbar_discover_selected"];
    
    mdbProfileViewController *profile = [[mdbProfileViewController alloc]init];
    [self addChildVc:profile andTitle:@"我" andImage:@"tabbar_profile" andSelected:@"tabbar_profile_selected"];
    
    
    //添加子控制器
    [tabbarVc addChildViewController:home];
    [tabbarVc addChildViewController:message];
    [tabbarVc addChildViewController:discover];
    [tabbarVc addChildViewController:profile];
    
    return YES;
}

- (void)addChildVc:(UIViewController*)childVc andTitle:(NSString *)title andImage:(NSString *)image andSelected:(NSString *)selectedImage
{
    
    //设置图片样式
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *proSelectedImage = [UIImage imageNamed:selectedImage];
    proSelectedImage = [proSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = proSelectedImage;
    
    //设置文字的样式
    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
    textArrs[NSForegroundColorAttributeName] = RGBColor(123, 123, 123);
    [childVc.tabBarItem setTitleTextAttributes:textArrs forState:UIControlStateNormal];
    NSMutableDictionary *selectTextArrs = [NSMutableDictionary dictionary];
    selectTextArrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectTextArrs forState:UIControlStateSelected];
    
    //设置tabbar背景颜色
    childVc.view.backgroundColor = mdb_RandomColor;
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

//    //设置子控制器
//
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.view.backgroundColor = mdb_RandomColor;
//    vc1.tabBarItem.title = @"首页";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//    //以原始的样式现实这张图片
//    UIImage *homeSelectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
//    homeSelectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem.selectedImage = homeSelectedImage;
//    //文字选中的色彩改变
//    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
//    textArrs[NSForegroundColorAttributeName] = RGBColor(123, 123, 123);
//    [vc1.tabBarItem setTitleTextAttributes:textArrs forState:UIControlStateNormal];
//
//    NSMutableDictionary *selectTextArrs = [NSMutableDictionary dictionary];
//    selectTextArrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [vc1.tabBarItem setTitleTextAttributes:selectTextArrs forState:UIControlStateSelected];
//
//
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.view.backgroundColor = mdb_RandomColor;
//    vc2.tabBarItem.title = @"消息";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//    UIImage *messageSelectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
//    messageSelectedImage = [messageSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc2.tabBarItem.selectedImage =messageSelectedImage;
//    [vc2.tabBarItem setTitleTextAttributes:textArrs forState:UIControlStateNormal];
//    [vc2.tabBarItem setTitleTextAttributes:selectTextArrs forState:UIControlStateSelected];
//
//
//    UIViewController *vc3 = [[UIViewController alloc]init];
//    vc3.view.backgroundColor = mdb_RandomColor;
//    vc3.tabBarItem.title = @"发现";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//    UIImage *discoverSelectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
//    discoverSelectedImage = [discoverSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc3.tabBarItem.selectedImage =discoverSelectedImage;
//    [vc3.tabBarItem setTitleTextAttributes:textArrs forState:UIControlStateNormal];
//    [vc3.tabBarItem setTitleTextAttributes:selectTextArrs forState:UIControlStateSelected];
//
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.view.backgroundColor = mdb_RandomColor;
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
//    UIImage *proSelectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
//    proSelectedImage = [proSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc4.tabBarItem.selectedImage = proSelectedImage;
//    [vc4.tabBarItem setTitleTextAttributes:textArrs forState:UIControlStateNormal];
//    [vc4.tabBarItem setTitleTextAttributes:selectTextArrs forState:UIControlStateSelected];
//
//
//    tabbarVc.viewControllers = @[vc1,vc2,vc3 ,vc4];

@end

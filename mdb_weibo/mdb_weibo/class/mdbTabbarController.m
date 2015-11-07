//
//  mdbTabbarController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTabbarController.h"
#import "mdbHomeController.h"
#import "mdbDiscoverController.h"
#import "mdbMessageController.h"
#import "mdbProfileViewController.h"

@interface mdbTabbarController ()

@end

@implementation mdbTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mdbHomeController *home = [[mdbHomeController alloc]init];
    [self addChildVc:home andTitle:@"首页" andImage:@"tabbar_home" andSelected:@"tabbar_home_selected"];
    
    mdbMessageController *message = [[mdbMessageController alloc]init];
    [self addChildVc:message andTitle:@"消息" andImage:@"tabbar_message_center" andSelected:@"tabbar_message_center_selected"];
    
    mdbDiscoverController *discover = [[mdbDiscoverController alloc]init];
    [self addChildVc:discover andTitle:@"搜索" andImage:@"tabbar_discover" andSelected:@"tabbar_discover_selected"];
    
    mdbProfileViewController *profile = [[mdbProfileViewController alloc]init];
    [self addChildVc:profile andTitle:@"我" andImage:@"tabbar_profile" andSelected:@"tabbar_profile_selected"];
    
}
- (void)addChildVc:(UIViewController*)childVc andTitle:(NSString *)title andImage:(NSString *)image andSelected:(NSString *)selectedImage
{
    
    //设置图片样式
    //childVc.tabBarItem.title = title;
    //childVc.navigationItem.title = title;
    childVc.title = title;//同时设置 tabbar 和 navigationbar的文字
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    //设置子控制器的图片
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
    //给childVc控制器包装navigation控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    
    //添加子控制器
    [self addChildViewController:nav];
}


@end

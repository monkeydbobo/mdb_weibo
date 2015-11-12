//
//  mdbNavigationController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/9.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbNavigationController.h"

@interface mdbNavigationController ()

@end

@implementation mdbNavigationController

+ (void)initialize{
    
    //设置整个项目所在的item样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置普通状态
    //key:NSForegro...AttributeName;
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disableTextAttr = [NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    disableTextAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];

    if (self.viewControllers.count > 1) {//保证push进来的不是第一个控制器

        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(back) andImage:@"navigationbar_back" andHighImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(more) andImage:@"navigationbar_more" andHighImage:@"navigationbar_more_highlighted"];
    }
}

- (void)back{
    NSLog(@"%@",self.navigationController);//self.navigation is nil
    
    [self  popViewControllerAnimated:YES];
}

- (void)more{
    //回到跟控制器
    [self popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

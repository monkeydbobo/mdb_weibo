//
//  mdbTest1ViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTest1ViewController.h"
#import "mdb.pch"
@interface mdbTest1ViewController ()

@end

@implementation mdbTest1ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置后退按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    backBtn.size = backBtn.currentBackgroundImage.size;
    
    //设置更多按钮
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    moreBtn.size = moreBtn.currentBackgroundImage.size;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn ];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more{
    //回到跟控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    mdbTest2ViewController *test2 =[[mdbTest2ViewController alloc]init];
    test2.title = @"测试控制器2";
    test2.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test2 animated:YES];
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

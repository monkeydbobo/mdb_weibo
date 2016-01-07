//
//  mdbTest2ViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTest2ViewController.h"
#import "mdb.pch"
#import "mdbTest3TableViewController.h"
@interface mdbTest2ViewController ()

@end

@implementation mdbTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    mdbTest3TableViewController *test3 =[[mdbTest3TableViewController alloc]init];
    test3.title = @"测试控制器3";
     [self.navigationController pushViewController:test3 animated:YES];
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

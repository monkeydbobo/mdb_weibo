//
//  mdbMessageController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbMessageController.h"

@interface mdbMessageController ()

@end

@implementation mdbMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    
    //设置不可用的时候状态
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
}
- (void)composeMsg{
    
    NSLog(@"写私信...");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    //返回当前TableView有几个分区
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test--message--%d",indexPath.row];
    
    return cell;
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    mdbTest1ViewController *test1 = [[mdbTest1ViewController alloc]init];
    test1.title = @"测试控制器1";
    //test1控制器被push的时候，tabbar会自动隐藏
    //test1控制器被pop的时候，tabbar会自动现实 
    test1.hidesBottomBarWhenPushed = YES;
     NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:test1 animated:YES];
    //选择tabbarController所在的控制器的NavigationController

    
}

@end

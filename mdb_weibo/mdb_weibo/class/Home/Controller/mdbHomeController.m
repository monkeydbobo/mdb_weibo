//
//  mdbHomeController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbHomeController.h"
#import "mdbDropMenu.h"
#import "mdbTitleMenuTableViewController.h"

@interface mdbHomeController ()

@end

@implementation mdbHomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //左右按键
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(friendSearch) andImage:@"navigationbar_friendsearch" andHighImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(pop) andImage:@"navigationbar_pop" andHighImage:@"navigationbar_pop_highlighted"];
    
    
    //中间的标题按钮
    UIButton *btn = [[UIButton alloc]init];
    btn.width = 150;
    btn.height = 30;

    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];//设置粗体
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    
    //监听标题点击
    [btn addTarget:self  action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = btn;
    
    UIButton *mBtn = [[UIButton alloc]init];
    mBtn.backgroundColor = [UIColor redColor];
    mBtn.width = 100;
    mBtn.x = 80;
    mBtn.y = 30;
    mBtn.height = 30;
    [mBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mBtn];
}
- (void)titleClick:(UIButton *)titleButton {
    
    mdbDropMenu *dropMenu = [mdbDropMenu menu];
    mdbTitleMenuTableViewController *vc = [[mdbTitleMenuTableViewController alloc]init];
    vc.view.height = 44*3;
    vc.view.width = 250;
    dropMenu.contentController = vc;
    
    [dropMenu showFrom:titleButton];
    
}

- (void)friendSearch{
    
    NSLog(@"Search...");
    
}
- (void)pop{
    
    NSLog(@"pop...");
}
\
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

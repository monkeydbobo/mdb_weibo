//
//  mdbTitleMenuTableViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/16.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTitleMenuTableViewController.h"

@interface mdbTitleMenuTableViewController ()

@end

@implementation mdbTitleMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0){
        cell.textLabel.text = @"好友圈";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"LOL";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"基友";
    }
    
    return cell;
}

@end

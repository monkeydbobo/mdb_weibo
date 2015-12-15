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
#import "AFNetworking.h"
#import "mdbAccountTools.h"
#import "MBProgressHUD+NJ.h"
#import "mdbTitleButton.h"
@interface mdbHomeController () <mdbDropMenuDelegate>
@property (nonatomic,strong) UIButton *titleBtn;
@end

@implementation mdbHomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置用户信息
    [self setupUserInfo];
    //设置导航栏内容
    [self setupNav];
    
    //加载微博数据
    [self loadNewStatus];
    
}
- (void)loadStatus{
    
}
- (void)setupUserInfo
{
    NSString* url = @"https://api.weibo.com/2/users/show.json";
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    params [@"uid"] = account.uid;
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        NSLog(@"请求成功--%@",responseObject);
        //存储名字到沙盒中
        NSString *name = responseObject[@"name"];
        account.name = name;
        [mdbAccountTools saveAccount:account];
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        NSLog(@"请求失败--%@",error);
    }];

}
- (void)setupNav
{
    //左右按键
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(friendSearch) andImage:@"navigationbar_friendsearch" andHighImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(pop) andImage:@"navigationbar_pop" andHighImage:@"navigationbar_pop_highlighted"];
    
    
    //中间的标题按钮
    mdbTitleButton *titleButton = [[mdbTitleButton alloc]init];
    NSString *name = [mdbAccountTools account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //监听标题点击
    [titleButton addTarget:self  action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =titleButton;
    self.titleBtn = titleButton;
   
}
- (void)titleClick:(UIButton *)titleButton {
    
    mdbDropMenu *dropMenu = [mdbDropMenu menu];
    
    dropMenu.delegate = self;
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

- (void)dropMenuDidDismiss:(mdbDropMenu *)menu
{
    self.titleBtn.selected = NO;
}
- (void)dropMenuDidShow:(mdbDropMenu *)menu
{
    self.titleBtn.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

@end
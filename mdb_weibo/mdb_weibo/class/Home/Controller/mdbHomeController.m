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

@interface mdbHomeController () <mdbDropMenuDelegate>
@property (nonatomic,strong) UIButton *titleBtn;
@end

@implementation mdbHomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNav];
    
    //设置用户信息
    [self setupUserInfo];
    
}
- (void)setupUserInfo
{
    NSString* url = @"https://api.weibo.com/2/users/show.json";
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    params [@"uid"] = account.uid;
//    NSLog(@"access_token = %@",account.access_token);
//    NSLog(@"uid = %@",account.uid);
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        NSLog(@"请求成功--%@",responseObject);
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        NSString *name = responseObject[@"name"];
        [titleButton setTitle:name forState:UIControlStateNormal];
        
        //存储到沙盒中
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
    UIButton *btn = [[UIButton alloc]init];
    btn.width = 150;
    btn.height = 30;
    
    //设置图片和文字
    NSString *name = [mdbAccountTools account].name;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];//设置粗体
    
    [btn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    
    //监听标题点击
    [btn addTarget:self  action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = btn;
    self.titleBtn = btn;

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
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
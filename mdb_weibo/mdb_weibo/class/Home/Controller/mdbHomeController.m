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
#import "UIImageView+WebCache.h"
#import "MDBUser.h"
#import "MDBStatus.h"

@interface mdbHomeController () <mdbDropMenuDelegate>
@property (nonatomic,strong) UIButton *titleBtn;
/*
 *微博数组，每一个数组代表一条微博
 */
@property (nonatomic,strong) NSMutableArray *statuses;

@end

@implementation mdbHomeController
- (NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置用户信息
    [self setupUserInfo];
    //设置导航栏内容
    [self setupNav];
    
    //加载微博数据
    [self loadNewStatus];
    
}
- (void)loadNewStatus{
    
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        NSLog(@"请求成功--%@",responseObject);
        //取得微博字典数组
        NSArray *dictArray = responseObject[@"statuses"];
        //将“微博字典”数组 转为 “微博模型”数组
        for (NSDictionary *dict in dictArray) {
            MDBStatus *status = [MDBStatus statusWithDict:dict];
            [self.statuses addObject:status];
        }
        //刷新表格
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        NSLog(@"请求失败--%@",error);
    }];

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
//        NSLog(@"请求成功--%@",responseObject);
        //存储名字到沙盒中
        MDBUser *user = [MDBUser userWithDict:responseObject];
        NSString *name = user.name;
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
    titleButton.width = 150;
    titleButton.height = 30;
    titleButton.backgroundColor = [UIColor redColor];
    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageView.backgroundColor = [UIColor yellowColor];

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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"cid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cid];
    }
    //取出这行对应的字典
    MDBStatus *status = self.statuses[indexPath.row];
    
    //取出这条微博的作 者(用户)
    MDBUser *user = status.user;
    cell.textLabel.text = user.name;
    NSLog(@"名字%@",user.name);
    NSLog(@"%@",user.profile_image_url);
    //获取头像
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholder];
    
    //设置微博的文字
    cell.detailTextLabel.text = status.text;
    return cell;
}
/*1.把字典转成模型*/

@end
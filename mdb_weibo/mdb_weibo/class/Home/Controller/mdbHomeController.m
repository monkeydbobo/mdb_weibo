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
#import "MJExtension.h"
#import "MDBLoadMoreFooter.h"

@interface mdbHomeController () <mdbDropMenuDelegate>
@property (nonatomic,strong) UIButton *titleBtn;
/*
 *微博数组，每一个数组代表一条微博
 */
@property (nonatomic,strong) NSMutableArray *statuses;

//@property (nonatomic,strong) MDBLoadMoreFooter *footer;

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
    
    //集成下拉刷新控件
    [self setupRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];
}
- (void)setupUpRefresh
{
    MDBLoadMoreFooter *footer = [MDBLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}

- (void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    //手动下拉刷新才会触发valueChange事件
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.马上进入刷新状态,仅仅是进入刷新界面，不会触发valuechange事件
    [control beginRefreshing];
    [self refreshStateChange:control];
}
- (void)loadMoreStatus
{
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    
    MDBStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        //        NSLog(@"请求成功--%@",responseObject);
        //将“微博字典”数组 转为 “微博模型”数组
        NSArray *newStatues = [MDBStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //把新的微博数据添加到数组的后面
        [self.statuses addObjectsFromArray:newStatues];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新，隐藏foot
        self.tableView.tableFooterView.hidden = YES;
        
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        NSLog(@"请求失败--%@",error);
        //隐藏foot
        self.tableView.tableFooterView.hidden = YES;

    }];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollView == self.tableView == self.view
    if (self.statuses.count == 0 || self.tableView.tableFooterView.hidden == NO)
        return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
}
    
- (void)refreshStateChange:(UIRefreshControl *)control
{
    NSLog(@"刷新！！！！");
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    MDBStatus *firstStaus = [self.statuses firstObject];
    //若指定此参数，则返回ID比since_id大的微博
    params [@"since_id"] = firstStaus.idstr;
    if (firstStaus) {
        params[@"since_id"] = firstStaus.idstr;
    }
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        //将“微博字典”数组 转为 “微博模型”数组
        NSArray *newStatues = [MDBStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatues.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatues atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示刷新的条数
        [self showNewStatusCount:newStatues.count];
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        NSLog(@"请求失败--%@",error);
        
        [control endRefreshing];
    }];
}
/*
 *显示最新的微博数量
 */
- (void)showNewStatusCount:(int)count
{
    //1.创建Lable
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据";

    }else{
        label.text = [NSString stringWithFormat:@"共有%d条微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //3.添加到tableview
    label.y = 64-label.height;
    //将Label添加到导航控制器的view中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.添加动画（利用1S的时间往下移动自己高度的距离，然后延迟一秒向上移动，从父控件移除）
    CGFloat duration = 1.0;//动画的时间
    [UIView animateWithDuration:duration animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    }completion:^(BOOL finished){
        CGFloat delay = 1.0;//延迟1s
        //UIViewAnimationOptionCurveLinear 线性，匀速执行
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished){
            [label removeFromSuperview];
        }];
    }];
}
- (void)loadNewStatus{
    
    NSString* url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mdbAccount *account = [mdbAccountTools account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"access_token"] = account.access_token;
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
//        NSLog(@"请求成功--%@",responseObject);
        //将“微博字典”数组 转为 “微博模型”数组
        NSArray *newStatues = [MDBStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

        //将新的数据添加到数组的后面
        [self.statuses addObjectsFromArray:newStatues];
        
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
        MDBUser *user = [MDBUser objectWithKeyValues:responseObject];
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
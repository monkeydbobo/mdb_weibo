//
//  oAuthViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/30.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//
#import "mdbTabbarController.h"
#import "oAuthViewController.h"
#import "AFNetworking.h"
#import "mdbAccount.h"
#import "mdbAccountTools.h"
#import "MBProgressHUD+NJ.h"
@interface oAuthViewController () <UIWebViewDelegate>

@end

@implementation oAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    //加载
    //请求参数
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1345659523&redirect_uri=http://github.com/monkeydbobo"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        NSLog(@"code = %@",code);
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return NO;
    }
    return YES;
}
/*
 利用授权成功后的请求标记
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	tr
 */
- (void)accessTokenWithCode:(NSString *)code
{
    //请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params [@"client_id"] =@"1345659523";
    params [@"client_secret"] =@"d46056ddf906f8f6a00e3b09bb43c723";
    params [@"grant_type"] =@"authorization_code";
    params [@"code"] = code;
    params [@"redirect_uri"] =@"http://github.com/monkeydbobo";
    
    [manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject){
        [MBProgressHUD hideHUD];
        
        mdbAccount *account = [mdbAccount accountWithDict:responseObject];
        //存储账号信息
        [mdbAccountTools saveAccount:account];
        
        //切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    }failure:^(AFHTTPRequestOperation *opreation,NSError *error){
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败--%@",error);
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载... "];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
@end

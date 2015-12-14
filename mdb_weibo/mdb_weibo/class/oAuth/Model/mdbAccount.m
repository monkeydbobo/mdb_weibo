//
//  mdbAccount.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbAccount.h"
/*
{
    "access_token": "ACCESS_TOKEN",
    "expires_in": 1234,
    "remind_in":"798114",
    "uid":"12341234"
}
*/
@implementation mdbAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    mdbAccount *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    //获取账号的存储时间
    account.created_time = [NSDate date];
    return account;
}
/*
 *
 *当一个应用归档进沙盒的时候调用这个方法
 *在这个方法中说明这个对象中的那些属性需要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
/*
 *在沙盒中解党一个对象时
 *目的：在这个方法中说明沙盒中属性该怎么解析
 *沙盒中需要取出哪些属性
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self == [super init]){
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        
    }
    return self;
}
@end

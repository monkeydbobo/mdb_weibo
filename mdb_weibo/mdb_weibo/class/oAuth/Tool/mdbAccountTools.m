//
//  mdbAccountTools.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/8.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//
#define mdbAccountPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "mdbAccountTools.h"


@implementation mdbAccountTools

+ (void)saveAccount:(mdbAccount *)account
{
    //获取账号存储的时间
    
    [NSKeyedArchiver archiveRootObject:account toFile:mdbAccountPath];
}
+ (mdbAccount *)account
{
    //加载模型
    mdbAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:mdbAccountPath];
    
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    //过期时间
    NSDate *expriseTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获取当前的时间
    NSDate *now = [NSDate date];
    //now >= exprisetime就过期
    /*NSOrderedAscending = -1L,
     *NSOrderedSame, 
     *NSOrderedDescending
     */
    NSComparisonResult result = [expriseTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    NSLog(@"exprise = %@  now = %@",expriseTime ,now);
    return account;
}
@end

//
//  mdbAccountTools.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/8.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mdbAccount.h"

@interface mdbAccountTools : NSObject
//存储账号信息
+ (void)saveAccount:(mdbAccount *)account;
+ (mdbAccount *)account;
@end

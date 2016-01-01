//
//  MDBStatus.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/17.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDBUser.h"
@interface MDBStatus : NSObject
/*
idstr	string	字符串型的微博ID
text    string  微博的内容
user	object	微博作者的用户信息字段 详细
 */
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) MDBUser *user;

@end

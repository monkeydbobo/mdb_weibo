//
//  MDBStatus.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/17.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//  微博模型

#import "MDBStatus.h"
#import "MDBUser.h"

@implementation MDBStatus
+(instancetype)statusWithDict:(NSDictionary *)dict
{
    MDBStatus *status = [[MDBStatus alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [MDBUser userWithDict:dict[@"user"]] ;
    return status; 
}
@end

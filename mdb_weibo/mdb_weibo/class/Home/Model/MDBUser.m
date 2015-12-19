//
//  MDBUser.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/17.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "MDBUser.h"

@implementation MDBUser
+ (instancetype)userWithDict:(NSDictionary *)dict
{
    MDBUser *user = [[MDBUser alloc]init];
    user.name = dict[@"name"];
    user.idStr = dict[@"idStr"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}
@end

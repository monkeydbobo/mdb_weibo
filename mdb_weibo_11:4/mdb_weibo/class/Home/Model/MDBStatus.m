//
//  MDBStatus.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/17.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//  微博模型

#import "MDBStatus.h"
#import "MJExtension.h"
#import "MDBPhoto.h"

@implementation MDBStatus
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"pic_urls" : [MDBPhoto class]
    };
}
@end

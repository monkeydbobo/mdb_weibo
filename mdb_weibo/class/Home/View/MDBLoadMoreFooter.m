//
//  MDBLoadMoreFooter.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/19.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "MDBLoadMoreFooter.h"

@implementation MDBLoadMoreFooter
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MDBLoadMoreFooter" owner:nil options:nil]lastObject];
}
@end

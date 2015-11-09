//
//  mdbItemTool.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/9.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbItemTool.h"
#import "mdb.pch"

@implementation mdbItemTool

+ (UIBarButtonItem *)itemWithAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn  setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end

//
//  mdbTabBar.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/18.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTabBar.h"

@implementation mdbTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.width / count;
            child.backgroundColor = [UIColor redColor];
        }
    }
    
}
@end

//
//  mdbTabBar.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/18.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTabBar.h"

@interface mdbTabBar ()

@property (nonatomic,weak) UIButton *plusBtn;

@end

@implementation mdbTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self == [super initWithFrame:frame]) {
     
        UIButton *plusBtn = [[UIButton alloc]init];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)plusClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarClickPlusButton:)]){
        [self.delegate tabBarClickPlusButton:self];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.plusBtn.centerY = self.height * 0.5;
    self.plusBtn.centerX = self.width * 0.5;
    
    //设置其他tabBarButton的位置和尺寸
    CGFloat tabbrButtonW = self.width / 5.0;
    CGFloat tabbarButtonIndex = 0;
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbrButtonW;
            child.x = tabbarButtonIndex * tabbrButtonW;
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2){
                tabbarButtonIndex++;
            }
        }
    }
    
}
@end

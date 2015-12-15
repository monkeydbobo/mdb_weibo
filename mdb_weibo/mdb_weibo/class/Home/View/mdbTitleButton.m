//
//  mdbTitleButton.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/14.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbTitleButton.h"

@implementation mdbTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置内容居中
//        self.imageView.contentMode = UIViewContentModeCenter;
        //
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];//设置粗体
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end

//
//  mdbDropMenu.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/13.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbDropMenu.h"

@interface mdbDropMenu ()
@property (nonatomic,weak) UIImageView *containerView;
@end

@implementation mdbDropMenu
- (UIImageView *)containerView{
    if (!_containerView) {
        //添加灰色控件
        UIImageView *containerView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES; //开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
//        UIImageView *containerView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
//                containerView.width = 217;
//                containerView.height = 217;
//                [self addSubview:containerView];
//        self.containerView = containerView;
    }
    return self;
}
- (void)show{
    
    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //2.添加到自己的窗口上
    [window addSubview:self];
    //3.设置尺寸
    self.frame = window.bounds;
    
}

+(instancetype)menu{
    
    return [[self alloc]init];
}

- (void)setContentView:(UIView *)contentView{
    
    _contentView = contentView;
    //调整下拉框内容的位置
    contentView.x = 15;
    contentView.y = 25;
    
    //设置灰色的尺寸
    self.containerView.height = CGRectGetMaxY(contentView.frame) + 10;
    self.containerView.width = CGRectGetMaxX (contentView.frame) + 10;
    
    [self.containerView addSubview:contentView];
}
- (void)dismiss{
    
    [self removeFromSuperview];
}
@end
////为了保证下拉菜单的窗口在最上面
//UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//
////添加蒙版
//UIView *cover = [[UIView alloc]init];
////cover.backgroundColor = [UIColor clearColor];
//cover.frame = window.bounds;
//[window addSubview:cover];
//
////添加带箭头的图片
//UIImageView *dropdownMenu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
////如果图片的某个方向上不规则，比如有突起或者凹进去的，则这个方向就不能拉伸
//dropdownMenu.width = 217;
//dropdownMenu.height = 217;
//dropdownMenu.y = 150;
////UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//
//dropdownMenu.userInteractionEnabled = YES;
//[dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//[cover addSubview:dropdownMenu];
//
////相当于 self.view.window == [UIApplication sharedApplication].keyWindow;
//
//  mdbDropMenu.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/13.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mdbDropMenu : UIView

+ (instancetype)menu;

- (void)show;

- (void)dismiss;

@property (nonatomic,strong) UIView *contentView;

@end

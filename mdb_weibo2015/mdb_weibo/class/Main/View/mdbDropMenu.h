//
//  mdbDropMenu.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/13.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mdbDropMenu;

@protocol mdbDropMenuDelegate <NSObject>
@optional
- (void)dropMenuDidDismiss:(mdbDropMenu *)menu;
- (void)dropMenuDidShow:(mdbDropMenu *)menu;

@end

@interface mdbDropMenu : UIView

@property (nonatomic,weak) id<mdbDropMenuDelegate> delegate;
 
+ (instancetype)menu;

- (void)showFrom:(UIView *)from;

- (void)dismiss;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIViewController *contentController;


@end

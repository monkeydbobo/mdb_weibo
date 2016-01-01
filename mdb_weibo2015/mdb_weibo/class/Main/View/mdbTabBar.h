//
//  mdbTabBar.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/18.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mdbTabBar;

@protocol mdbTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarClickPlusButton:(mdbTabBar *)tabbar;

@end

@interface mdbTabBar : UITabBar
@property (nonatomic,weak) id<mdbTabBarDelegate> delegate;
@end

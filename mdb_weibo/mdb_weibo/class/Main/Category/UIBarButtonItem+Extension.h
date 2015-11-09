//
//  UIBarButtonItem+Extension.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/9.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage;
@end

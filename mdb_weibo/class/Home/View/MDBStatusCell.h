//
//  MDBStatusCell.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/30.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDBStatusFrame;

@interface MDBStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) MDBStatusFrame *statusFrame;
@end

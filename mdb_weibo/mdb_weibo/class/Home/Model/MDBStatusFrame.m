//
//  MDBStatusFrame.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/30.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//  一个frame内容里面包含的信息
//  1.存放着一个cell内部所有子控件的frame
//  2.存放着一个cell的高度
//  3.存放着一个数据模型MDBStatus
#import "MDBStatusFrame.h"
#import "MDBStatus.h"
//cell的边框宽度
#define IWStatusCellBorderW 10
@implementation MDBStatusFrame
- (void)setStatus:(MDBStatus *)status
{
    _status = status;
    
    /*原创微博*/
    
    /*头像*/
    CGFloat iconWH = 50;
    CGFloat iconX = IWStatusCellBorderW;
    CGFloat iconY = IWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /*会员图标*/
    
    /*配图*/
    
    /*昵称*/
    
    /*时间*/
    
    /*来源*/
    
    /*正文*/
    
    /**原创微博整体*/
    
    self.cellHeight = 70;
    
}
@end

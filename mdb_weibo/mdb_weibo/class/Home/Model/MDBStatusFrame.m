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
#import "MDBUser.h"
//cell的边框宽度
#define IWStatusCellBorderW 10


@implementation MDBStatusFrame
- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font
{
    return [self sizeWithText:text andFont:font andMaxW:MAXFLOAT];
}
- (void)setStatus:(MDBStatus *)status
{
    _status = status;
    MDBUser *user = status.user;
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /*原创微博*/
    
    /*头像*/
    CGFloat iconWH = 35;
    CGFloat iconX = IWStatusCellBorderW;
    CGFloat iconY = IWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /*昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + IWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name andFont:IWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /*会员图标*/
    if (status.user.mbrank > 2){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + IWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 16;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /*时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + IWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at andFont:IWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /*来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + IWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source andFont:IWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /*正文*/
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.timeLabelF), CGRectGetMaxY(self.iconViewF)) + IWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text andFont:IWStatusCellContentFont andMaxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /*配图*/
    CGFloat originalH = 0;
    if (status.pic_urls.count) {//you
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + IWStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + IWStatusCellBorderW;
    } else {//meiyou
        originalH = CGRectGetMaxY(self.contentLabelF) + IWStatusCellBorderW;
    }

    /**原创微博整体*/
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
//    originalH = CGRectGetMaxY(self.contentLabelF) + IWStatusCellBorderW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
    
}
@end

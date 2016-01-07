//
//  MDBStatusFrame.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/30.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

//昵称字体
#define IWStatusCellNameFont [UIFont systemFontOfSize:15]
//时间字体
#define IWStatusCellTimeFont [UIFont systemFontOfSize:12]

//来源字体
#define IWStatusCellSourceFont [UIFont systemFontOfSize:12]

//正文字体
#define IWStatusCellContentFont [UIFont systemFontOfSize:14]

//被转发微博的正文字体
#define IWRetweetStatusCellContentFont [UIFont systemFontOfSize:13]

@class MDBStatus;

@interface MDBStatusFrame : NSObject
@property (nonatomic,strong) MDBStatus *status;

//原创微博整体
@property (nonatomic,assign) CGRect originalViewF;
//头像
@property (nonatomic,assign) CGRect iconViewF;
//weibo配图
@property (nonatomic,assign) CGRect photoViewF;
//会员图标
@property (nonatomic,assign) CGRect vipViewF;
//昵称
@property (nonatomic,assign) CGRect nameLabelF;
/*时间*/
@property (nonatomic,assign) CGRect timeLabelF;
/**正文*/
@property (nonatomic,assign) CGRect contentLabelF;
/*来源*/
@property (nonatomic,assign) CGRect sourceLabelF;
/*cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;

/** 转发微博整体*/
@property (nonatomic,assign) CGRect retweetViewF;
/** 转发微博正文+昵称*/
@property (nonatomic,assign) CGRect retweetContentLabelF;
/** 转发配图*/
@property (nonatomic,assign) CGRect retweetPhotoViewF;
@end

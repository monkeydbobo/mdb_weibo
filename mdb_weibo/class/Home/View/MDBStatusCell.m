//
//  MDBStatusCell.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/30.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "MDBStatusCell.h"
#import "MDBStatus.h"
#import "MDBUser.h"
#import "MDBStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "MDBPhoto.h"

@interface MDBStatusCell()
//原创微博整体
@property (nonatomic,weak) UIView *originalView;
//头像
@property (nonatomic,weak) UIImageView *iconView;
//weibo配图
@property (nonatomic,weak) UIImageView *photoView;
//会员图标
@property (nonatomic,weak) UIImageView *vipView;
//昵称
@property (nonatomic,weak) UILabel *nameLabel;
/*时间*/
@property (nonatomic,weak) UILabel *timeLabel;
/**正文*/
@property (nonatomic,weak) UILabel *contentLabel;
/*来源*/
@property (nonatomic,weak) UILabel *sourceLabel;
/** 转发微博*/
/** 转发微博整体*/
@property (nonatomic,weak) UIView *retweetView;
/** 转发微博正文+昵称*/
@property (nonatomic,weak) UILabel *retweetContentLabel;
/** 转发配图*/
@property (nonatomic,weak) UIImageView *retweetPhotoView;

@end

@implementation MDBStatusCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cid = @"status";
    MDBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) {
        cell = [[MDBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cid];
    }
    return cell;
}
/*
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 *  cell的初始化方法，一个cell只会调用一次
 *
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /** 设置原创微博*/
        [self setupOriginal];
        
        /** 设置转发微博*/
//        [self setupRetweet];
        
    }
    return self;
}
- (void)setupOriginal
{
        //1.原创微博整体
        UIView *originalView = [[UIView alloc]init];
        [self.contentView addSubview:originalView];
//        originalView.backgroundColor = [UIColor redColor];
        self.originalView = originalView;
    
        UIImageView *iconView = [[UIImageView alloc]init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
    
        UIImageView *photoView = [[UIImageView alloc]init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
    
        /*会员图标*/
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [originalView addSubview:vipView];
        self.vipView = vipView;
    
        /*昵称*/
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = IWStatusCellNameFont;
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
    
        /** 时间图标 */
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = IWStatusCellTimeFont;
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;

        /*WEIBO正文*/
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.font = IWStatusCellContentFont;
        contentLabel.numberOfLines = 0;
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    
        /*Weibo来源*/
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = IWStatusCellSourceFont;
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
}
- (void)setupRetweet
{
    /** 转发微博整体*/
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博配图*/
    UIImageView *retweetPhotoView = [[UIImageView alloc]init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
    /** 转发WEIBO正文*/
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.font = IWRetweetStatusCellContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;

}
- (void)setStatusFrame:(MDBStatusFrame *)statusFrame
{
    MDBStatus *status = statusFrame.status;
    MDBUser *user = status.user;
    
    _statusFrame = statusFrame;
    
    /*原创微博整体*/
    self.originalView.frame = statusFrame.originalViewF;
    
    /*头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /*会员图标*/
    self.vipView.frame = statusFrame.vipViewF;
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }//cell里凡有YES必然有NO
    
    //配图
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        MDBPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
   
    
    /*昵称*/
    self.nameLabel.text = user.name;
    self.nameLabel.font = IWStatusCellNameFont;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /*时间*/
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    /*来源*/
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    
    /*正文*/
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /** 被转发的微博整体*/
//    if (status.retweeted_status) {
//        MDBStatus *retweet_status = status.retweeted_status;
//        MDBUser *retweet_status_user = retweet_status.user;
//        
//        self.retweetView.hidden = NO;
//        self.retweetView.frame = statusFrame.retweetViewF;
//        
//        /** 正文*/
//        NSString *retweetContent = [NSString stringWithFormat:@"%@ : %@",retweet_status_user.name,retweet_status.text];
//        self.retweetContentLabel.text = retweetContent;
//        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
//        
//        /** 转发微博配图*/
//        if (retweet_status.pic_urls.count) {
//            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
//            MDBPhoto *retweetPhoto = [retweet_status.pic_urls firstObject];
//            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//            
//            self.photoView.hidden = NO;
//        }else{
//            self.photoView.hidden = YES;
//        }
//
//    }else{
//        self.retweetView.hidden = YES;
//    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

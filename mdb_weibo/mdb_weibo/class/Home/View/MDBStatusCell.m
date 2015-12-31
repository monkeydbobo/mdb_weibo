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
        //1.原创微博整体
        UIView *originalView = [[UIView alloc]init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        UIImageView *iconView = [[UIImageView alloc]init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *photoView = [[UIImageView alloc]init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
        
        UIImageView *vipView = [[UIImageView alloc]init];
        [originalView addSubview:vipView];
        self.vipView = vipView;
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [[UILabel alloc]init];
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
    
        UILabel *contentLabel = [[UILabel alloc]init];
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
    }
    return self;
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
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    
    /*配图*/
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
    /*昵称*/
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /*时间*/
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    /*来源*/
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    /*正文*/
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

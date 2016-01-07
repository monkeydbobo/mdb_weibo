//
//  MDBUser.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/17.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBUser : NSObject
//字符串型uid
@property (nonatomic,copy) NSString *idStr;

//用户姓名
@property (nonatomic,copy) NSString *name;

//用户头像
@property (nonatomic,copy) NSString *profile_image_url;

/*会员类型 如果mbtype>2 代表是会员*/
@property (nonatomic,assign) int mbtype;

/*会员等级*/
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter = isVip) BOOL vip;
@end

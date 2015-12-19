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

+ (instancetype)userWithDict:(NSDictionary *)dict;
@end

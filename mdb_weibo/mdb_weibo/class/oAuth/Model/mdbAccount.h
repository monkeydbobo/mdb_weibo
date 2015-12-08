//
//  mdbAccount.h
//  mdb_weibo
//
//  Created by wanghaobo on 15/12/7.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*返回值字段	字段类型	字段说明
access_token	string	用于调用access_token，接口获取授权后的access token。
expires_in	string	access_token的生命周期，单位是秒数。
remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
uid	string	当前授权用户的UID。
*/
@interface mdbAccount : NSObject <NSCoding>
//string	用于调用access_token，接口获取授权后的access token。
@property (nonatomic,strong) NSString *access_token;

//access_token的生命周期，单位是秒数。
@property (nonatomic,strong) NSNumber *expires_in;

//当前授权用户的UID。
@property (nonatomic,strong) NSString *uid;

//账号的创建时间access_token的获得时间
@property (nonatomic,strong) NSDate *created_time;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end

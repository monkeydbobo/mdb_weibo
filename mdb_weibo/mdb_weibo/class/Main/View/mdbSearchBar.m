//
//  mdbSearchBar.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/12.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "mdbSearchBar.h"

@implementation mdbSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        
        //设置ImageIcon
        //通过 initWithImage 方法创建的对象，image为图片尺寸
        UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        //    UIImageView *searchIcon = [[UIImageView alloc]init];
        //    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //这种方法创建的，没有尺寸
        searchIcon.height = 30;
        searchIcon.width = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+ (instancetype)searchBar{
    
    return [[self alloc]init];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

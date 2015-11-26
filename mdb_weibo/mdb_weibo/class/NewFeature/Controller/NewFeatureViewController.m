//
//  NewFeatureViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/26.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "NewFeatureViewController.h"
#define mdbNewfeatureCount 4

@interface NewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建一个scrollView：显示所有的新特性
    UIScrollView *scView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scView];
 
    
    //添加图片到scrollView;
    CGFloat scrollH = scView.height;
    CGFloat scrollW = scView.width;
    for (int i = 0; i < mdbNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * imageView.width;
        //显示图片
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [scView addSubview:imageView];
    }
    //设置scrollView的其他属性,如果想要某个方向上不能滚动，对应方向上的数值传0
    scView.contentSize = CGSizeMake(mdbNewfeatureCount * scrollW,0);
    scView.bounces = NO;//去除弹簧效果
    scView.pagingEnabled = YES;
    scView.showsHorizontalScrollIndicator = NO;
    scView.delegate = self;
    
    //添加pagecontroller
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = mdbNewfeatureCount;
    [self.view addSubview:self.pageControl];
    //pageControl就算没有设置内容，里面的东西也是能照常显示的
    self.pageControl.centerX = scView.width * 0.5;
    self.pageControl.centerY = scrollH - 50;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = RGBColor(253, 98, 42);
    self.pageControl.pageIndicatorTintColor = RGBColor(189, 189, 189);
   
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  NewFeatureViewController.m
//  mdb_weibo
//
//  Created by wanghaobo on 15/11/26.
//  Copyright © 2015年 wanghaobo. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "mdbTabbarController.h"
#define mdbNewfeatureCount 4

@interface NewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,weak) UIScrollView *scView;
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
        if (i == 3)
        {
            [self setupLastImageView:imageView];
        }
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
- (void)setupLastImageView:(UIImageView *)imageView
{
    //分享到微博
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    shareBtn.backgroundColor = [UIColor yellowColor];
//    shareBtn.titleLabel.backgroundColor = [UIColor redColor];
//    shareBtn.imageView.backgroundColor = [UIColor blueColor];
    [imageView addSubview:shareBtn];
    
    //开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}
- (void)startClick
{
    //切换到mdbTabbar
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[mdbTabbarController alloc]init];
}
- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
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

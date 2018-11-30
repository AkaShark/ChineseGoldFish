//
//  GFHomeFlowView.m
//  HQCardFlowView
//
//  Created by kys-20 on 10/09/2018.
//  Copyright © 2018 HQ. All rights reserved.
//
#define JkScreenHeight [UIScreen mainScreen].bounds.size.height
#define JkScreenWidth [UIScreen mainScreen].bounds.size.width

#import "GFHomeFlowView.h"
#import "UIImage+ImageEffects.h"

@implementation GFHomeFlowView
{
    NSInteger imageIndex;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        imageIndex = 0;
        self.backImageView.image = [[UIImage imageNamed:self.advArray[0]] blurImage];
        [self addSubview:self.backImageView];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.pageFlowView];
        [self.pageFlowView addSubview:self.pageC];
        [self.pageFlowView reloadData];
        
    }
    return self;
}

- (UIImageView *)backImageView
{
    if (!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _backImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backImageView;
}
- (NSMutableArray *)advArray
{
    if (!_advArray) {
        _advArray = [NSMutableArray arrayWithObjects:@"金鱼0",@"金鱼1",@"金鱼2", nil];
    }
    return _advArray;
}

#pragma mark -- 轮播图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, JkScreenWidth, 200)];
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (HQFlowView *)pageFlowView
{
    if (!_pageFlowView) {
        
        _pageFlowView = [[HQFlowView alloc] initWithFrame:CGRectMake(0, 0, JkScreenWidth, 200)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.3;
//        _pageFlowView.leftRightMargin = 20;
//        _pageFlowView.topBottomMargin = 20;
        _pageFlowView.orginPageCount = _advArray.count;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3.0;
        _pageFlowView.orientation = HQFlowViewOrientationHorizontal;
        
    }
    return _pageFlowView;
}

- (HQImagePageControl *)pageC
{
    if (!_pageC) {
        
        //初始化pageControl
        if (!_pageC) {
            _pageC = [[HQImagePageControl alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - 15, self.scrollView.frame.size.width, 7.5)];
        }
        [self.pageFlowView.pageControl setCurrentPage:0];
        self.pageFlowView.pageControl = _pageC;
        
    }
    return _pageC;
}

#pragma mark JQFlowViewDelegate
- (CGSize)sizeForPageInFlowView:(HQFlowView *)flowView
{
    return CGSizeMake(JkScreenWidth-2*30, self.scrollView.frame.size.height-2*3);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex
{
    NSLog(@"点击第%ld个广告",(long)subIndex);
}
#pragma mark JQFlowViewDatasource
- (NSInteger)numberOfPagesInFlowView:(HQFlowView *)flowView
{
    return self.advArray.count;
}
- (HQIndexBannerSubview *)flowView:(HQFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    _bannerView = (HQIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!_bannerView) {
        _bannerView = [[HQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, self.pageFlowView.frame.size.width, self.pageFlowView.frame.size.height)];
        _bannerView.layer.cornerRadius = 5;
        _bannerView.layer.masksToBounds = YES;
        _bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.advArray[index]] placeholderImage:nil];
    //加载本地图片
    _bannerView.mainImageView.image = [UIImage imageNamed:self.advArray[index]];
//    self.backImage = bannerView.mainImageView.image;
    // 吭 顺序不对啊
//设置背景模糊效果 卡顿优化 背景模糊化的时候占有内存太大了
//    NSLog(@"%ld ----",(long)index);
//    if (index >2)
//    {
//        index -= 2;
//    }
//    else
//    {
//
//    }
//    self.backImageView.image = [[UIImage imageNamed:self.advArray[index]] blurImage];
//    NSLog(@"%ld -=-=",index);
    return _bannerView;
}



- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HQFlowView *)flowView
{
//    添加切换动画 减小视觉效果(卡顿) 大概解决了 但是多少还是有点卡顿的感觉 建辉给我题的一点我没看出来就是我以为单纯的是卡顿但是他说是后面的视觉效果（我想了想 感觉很在里）后期提升性能上的优化
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.8;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.backImageView.layer addAnimation:transition forKey:@"animation"];
    
    [self.pageFlowView.pageControl setCurrentPage:pageNumber];
//    设置背景effect
    if (imageIndex < self.advArray.count-1)
    {
        imageIndex++;
        self.backImageView.image = [[UIImage imageNamed:self.advArray[imageIndex]] blurImage];
    }
    else
    {
        imageIndex = 0;
        self.backImageView.image = [[UIImage imageNamed:self.advArray[imageIndex]] blurImage];
    }
}
#pragma mark --旋转屏幕改变JQFlowView大小之后实现该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        [coordinator animateAlongsideTransition:^(id context) { [self.pageFlowView reloadData];
        } completion:NULL];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc
{
    self.pageFlowView.delegate = nil;
    self.pageFlowView.dataSource = nil;
    [self.pageFlowView stopTimer];
}

@end

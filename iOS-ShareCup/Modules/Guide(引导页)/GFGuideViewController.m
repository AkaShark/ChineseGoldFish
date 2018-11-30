//
//  GFGuideViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/29.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFGuideViewController.h"
#import "Lottie.h"
#import "NSObject+LSHUIExtension.h"
#import "AppDelegate+AppService.h"
#import "UIView+LSHExtension.h"

@interface GFGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UIImageView *bubbleImgView;
@property (nonatomic,strong) UIImageView *phoneImgView;
@property (nonatomic,strong) UIImageView *phoneContentimgView;
@property (nonatomic,strong) UIView *phoneContentMaskView;
@property (nonatomic,copy) NSArray *page2Ads;
@property (nonatomic,copy) NSArray *page3Ads;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIImageView *launchMask;
@property (nonatomic,strong) LOTAnimationView *launchAnimation;

@end

@implementation GFGuideViewController
{
    CGFloat _phoneWidth;
    CGFloat _phoneHeight;
    CGFloat _phoneContentWidth;
    CGFloat _phoneContentHeight;
}

# pragma mark =====lifeCycle =====

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubViews];
    
    if (self.isShowLaunchAnimation)
    {
        [self setupLaunchMask];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_launchMask && _launchAnimation)
    {
        __weak typeof(self) WeakSelf = self;
        [_launchAnimation playWithCompletion:^(BOOL animationFinished) {
            [UIView animateWithDuration:0.3 animations:^{
                WeakSelf.launchMask.alpha = 0;
            } completion:^(BOOL finished) {
                [WeakSelf.launchAnimation removeFromSuperview];
                WeakSelf.launchAnimation = nil;
                [WeakSelf.launchMask removeFromSuperview];
                WeakSelf.launchMask = nil;
            }];
        }];
    }
}
# pragma mark ===== userInteraction =====
- (void)start{
    [self removeFromParentViewController];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"guided"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate *appleDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appleDelegate initRootController];
}


# pragma mark ===== private =====
- (void)setupLaunchMask
{
    _launchMask = [UIImageView imageViewWithFrame:self.view.bounds image:[UIImage imageNamed:@"launchAnimationBg"]];
    [self.view addSubview:_launchMask];
    
    _launchAnimation = [LOTAnimationView animationNamed:@"launchAnimation"];
    _launchAnimation.cacheEnable = NO;
    _launchAnimation.frame = self.view.bounds;
    _launchAnimation.contentMode = UIViewContentModeScaleToFill;
    _launchAnimation.animationSpeed = 1.2;
    
    [_launchMask addSubview:_launchAnimation];
}


- (void)setupSubViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(KScreenWidth*3,0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
//    修改成用bundle管理
    _bgImgView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, KScreenWidth*3, KScreenHeight) image:[UIImage imageNamed:@"guideBg1"]];
    [self.view addSubview:_bgImgView];
    
    _bubbleImgView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) image:[UIImage imageNamed:@"guideBg2"]];
    
    [self.view addSubview:_bubbleImgView];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:M_PI *2];
    rotationAnimation.duration = 220;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [_bubbleImgView.layer addAnimation:rotationAnimation forKey:nil];
    
    CGFloat bottomPadding =Screen58inch ? 9 * BAPadding : 4 * BAPadding;
    
    _phoneWidth = 0.71 * KScreenWidth;
    _phoneHeight = _phoneWidth * 996/497;
    _phoneImgView = [UIImageView imageViewWithFrame:CGRectMake(KScreenWidth/2-_phoneWidth/2, KScreenHeight-bottomPadding-_phoneHeight, _phoneWidth, _phoneHeight) image:[UIImage imageNamed:@"guidePhone"]];
    
    [self.view addSubview:_phoneImgView];
    
    UIImage *guideContentImage = [UIImage imageNamed:@"guideContent"];
    _phoneContentWidth = _phoneWidth *0.88;
    _phoneContentHeight = _phoneContentWidth *guideContentImage.size.height/(guideContentImage.size.width/3);
    
    _phoneContentMaskView = [[UIView alloc] initWithFrame:CGRectMake(_phoneWidth/2-_phoneContentWidth/2+1, 0.09*_phoneHeight, _phoneContentWidth, _phoneContentHeight)];
    _phoneContentMaskView.layer.masksToBounds = YES;
    [_phoneImgView addSubview:_phoneContentMaskView];
    
    _phoneContentimgView = [UIImageView imageViewWithFrame:CGRectMake(-1,0 , _phoneContentWidth *3, _phoneContentHeight) image:guideContentImage];
    
    [_phoneContentMaskView addSubview:_phoneContentimgView];
    
    NSMutableArray *temp2Array = [NSMutableArray array];
    CGFloat page2Width = 118;
    CGFloat page2Height = 76;
    
    for (NSInteger i =0; i<5; i++)
    {
        CGFloat x = KScreenWidth + _phoneWidth * 0.75 + 2.5 *BAPadding;
        CGFloat y = _phoneImgView.origin.y + 0.25* _phoneHeight + _phoneContentHeight/5*i*1.2;
        NSString *imageName = [NSString stringWithFormat:@"ad%zd",i+1];
        UIImageView *ad = [UIImageView imageViewWithFrame:CGRectMake(x, y, page2Width, page2Height) image:[UIImage imageNamed:imageName]];
        ad.alpha = 0;
        [_bgImgView addSubview:ad];
//        UI数组
        [temp2Array addObject:ad];
    }
    _page2Ads = temp2Array;
    
    NSMutableArray *temp3Array = [NSMutableArray array];
    CGFloat page3width = KScreenWidth - _phoneWidth *0.75 - 3 *BAPadding;
    CGFloat page3Height = page3width *235/298;
    for (NSInteger i =0; i<2; i++)
    {
        CGFloat x = 2*KScreenWidth + BAPadding;
        CGFloat y = _phoneImgView.origin.y + 0.2 *_phoneHeight + _phoneContentHeight/2 *i*0.75;
        NSString *imageName = [NSString stringWithFormat:@"ad%zd",i+6];
        UIImageView *ad = [UIImageView imageViewWithFrame:CGRectMake(x, y, page3width, page3Height) image:[UIImage imageNamed:imageName]];
        ad.alpha = 0;
        [_bgImgView addSubview:ad];
        [temp3Array  addObject:ad];
    }
    _page3Ads = temp3Array;
    
//    标题距离顶部的高度
     CGFloat topPadding = Screen58inch ? 9 * BAPadding : 3 * BAPadding;
    
//   一行解决控件的创建(nsobject拓展)
    [NSString translation:@"中国金鱼" CallbackStr:^(NSString * _Nonnull str) {
        _titleLabel = [UILabel labelWithFrame:CGRectMake(0, topPadding, KScreenWidth, 28) text:str color:[UIColor whiteColor] font:[UIFont systemFontOfSize:22 weight:UIFontWeightRegular] textAlignment:NSTextAlignmentCenter];
    }];
//    _titleLabel = [UILabel labelWithFrame:CGRectMake(0, topPadding, KScreenWidth, 28) text:@"中国金鱼" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:22 weight:UIFontWeightRegular] textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_titleLabel];
    
//    [NSString translation:@"一键搜索中国金鱼详细了解" CallbackStr:^(NSString * _Nonnull str) {
//        _detailLabel = [UILabel labelWithFrame:CGRectMake(0, _titleLabel.bottom, KScreenWidth, 43) text:str color:[UIColor whiteColor] font:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular] textAlignment:NSTextAlignmentCenter];
//    }];
    _detailLabel = [UILabel labelWithFrame:CGRectMake(0, _titleLabel.bottom, KScreenWidth, 43) text:@"一键搜索中国金鱼详细了解" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular] textAlignment:NSTextAlignmentCenter];
    _detailLabel.numberOfLines = 0;
    [self.view addSubview:_detailLabel];
    
    _startBtn = [UIButton buttonWithFrame:CGRectMake(KScreenWidth / 2 - 211.5 / 2, KScreenHeight - 68 - 3 * BAPadding, 203, 50) title:nil color:nil font:nil backgroundImage:[UIImage imageNamed:@"startNow"] target:self action:@selector(start)];
    _startBtn.alpha = 0;
    [self.view addSubview:_startBtn];
}

# pragma mark ===== animation =====
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    __weak typeof(self) WeakSelf = self;
    
    if (offsetX < 0) {
        
        CGFloat bgScale = - offsetX / KScreenWidth + 1;
        _bgImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bubbleImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bgImgView.x = 0;
        _bubbleImgView.x = 0;
        
        _phoneContentimgView.x = - 1;
        
    } else if (offsetX > KScreenWidth * 2) {
        
        CGFloat bgScale = (offsetX - KScreenWidth * 2) / KScreenWidth + 1;
        _bgImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bubbleImgView.transform = CGAffineTransformMakeScale(bgScale, bgScale);
        _bgImgView.x = - KScreenWidth * 2;
        _bubbleImgView.x = - KScreenWidth;
        
        _phoneContentimgView.x = - 1 - 2 * _phoneContentWidth;
        
    } else {
        
        if (offsetX == 0) {
            if (![_titleLabel.text isEqualToString:@"中国金鱼"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                    [NSString translation:@"中国金鱼" CallbackStr:^(NSString * _Nonnull str) {
                        WeakSelf.titleLabel.text = str;
                    }];
//                    WeakSelf.titleLabel.text = @"中国金鱼";
                    WeakSelf.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:WeakSelf.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        [NSString translation:@"一键搜索中国金鱼详细了解" CallbackStr:^(NSString * _Nonnull str) {
                            WeakSelf.detailLabel.text = str;
                        }];
//                        WeakSelf.detailLabel.text = @"一键搜索中国金鱼详细了解";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
        } else if (offsetX == KScreenWidth) {
            if (![_titleLabel.text isEqualToString:@"金鱼分类"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
//                    [NSString translation:@"金鱼分类" CallbackStr:^(NSString * _Nonnull str) {
//                        WeakSelf.titleLabel.text = str;
//                    }];
                    WeakSelf.titleLabel.text = @"金鱼分类";
                    WeakSelf.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:WeakSelf.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        [NSString translation:@" 全部种类\n经典分类/传统分类" CallbackStr:^(NSString * _Nonnull str) {
                            WeakSelf.detailLabel.text = str;
                        }];
//                        WeakSelf.detailLabel.text = @"  全部种类\n经典分类/传统分类";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
        } else if (offsetX == 2 * KScreenWidth) {
            if (![_titleLabel.text isEqualToString:@"图鉴和养殖"]) {
                [UIView transitionWithView:_titleLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                    [NSString translation:@"图鉴和养殖" CallbackStr:^(NSString * _Nonnull str) {
                        WeakSelf.titleLabel.text = str;
                    }];
//                    WeakSelf.titleLabel.text = @"图鉴和养殖";
                    WeakSelf.detailLabel.text = nil;
                } completion: ^(BOOL isFinished) {
                    [UIView transitionWithView:WeakSelf.detailLabel duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
                        [NSString translation:@"品鉴各类金鱼丰富养殖知识" CallbackStr:^(NSString * _Nonnull str) {
                            WeakSelf.detailLabel.text = str;
                        }];
//                        WeakSelf.detailLabel.text = @"品鉴各类金鱼丰富养殖知识";
                    } completion: ^(BOOL isFinished) {
                        
                    }];
                }];
            }
            
            [UIView animateWithDuration:0.8 animations:^{
               WeakSelf.startBtn.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:0.8 animations:^{
                WeakSelf.startBtn.alpha = 0;
            }];
        }
        
        //背景图
        _bgImgView.transform = CGAffineTransformIdentity;
        _bgImgView.x = - offsetX;
        _bubbleImgView.x = - offsetX / 2;
        
        //手机框
        if (offsetX < KScreenWidth) {
            CGFloat delta = KScreenWidth - offsetX;
            CGFloat phoneSacle = delta * 0.25 / KScreenWidth + 0.75;
            CGFloat phoneMove = - (1 - phoneSacle) * _phoneWidth;
            
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(phoneSacle, phoneSacle);
            CGAffineTransform moveTansnform = CGAffineTransformMakeTranslation(phoneMove, 0);
            _phoneImgView.transform = CGAffineTransformConcat(scaleTransform, moveTansnform);
            
        } else if (offsetX < KScreenWidth * 2) {
            
            CGFloat delta = 2 * KScreenWidth - offsetX;
            CGFloat phoneMove =  (1 - delta / KScreenWidth) * (0.5 * _phoneWidth) - 0.25 * _phoneWidth;
            
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            CGAffineTransform moveTansnform = CGAffineTransformMakeTranslation(phoneMove, 0);
            _phoneImgView.transform = CGAffineTransformConcat(scaleTransform, moveTansnform);
            
        }
        
        //手机内容
        _phoneContentimgView.x = - 1 - offsetX * _phoneContentWidth / KScreenWidth;
        
        //广告2
        CGFloat page2Delta = fabs(offsetX - KScreenWidth);
        for (UIImageView *ad in _page2Ads) {
            CGFloat alpha =  1 - page2Delta / (KScreenWidth / 2);
            ad.alpha = alpha;
        }
        
        //广告3
        CGFloat page3Delta = fabs(offsetX - 2 * KScreenWidth);
        for (UIImageView *ad in _page3Ads) {
            CGFloat alpha =  1 - page3Delta / (KScreenWidth / 2);
            ad.alpha = alpha;
        }
    }
}



@end

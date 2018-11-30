//
//  GFBreedViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/17.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFBreedViewController.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"
#import "GFHomeViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "WXSTransitionProperty.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "GFWebViewViewController.h"

@interface GFBreedViewController ()<YSLDraggableCardContainerDelegate,YSLDraggableCardContainerDataSource>

@end

@implementation GFBreedViewController

//请求数据
- (void)requestTheData{
    
    [POST_GET GET:@"http://47.104.211.62/GlodFish/glodFishData.php?type=breed" parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [responseObject objectForKey:@"result"];
        self->_urlArray = [dic objectForKey:@"url"];
        self->_imageArray = [dic objectForKey:@"image"];
        
        self->_titleArray = [dic objectForKey:@"title"];
        NSLog(@"%lu",(unsigned long)self->_imageArray.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initUI];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestTheData];
    
    [NSString translation:@"金鱼养殖" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
}

#pragma mark ————— 创建UI界面 —————
-(void)initUI{
    // 创建 _container
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(self.view.size.width * 0.1, self.view.size.width * 0.3, self.view.frame.size.width - 72, self.view.frame.size.height - 300);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    //    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
    [self.view addSubview:_container];
    
    // 获取数据
    [self loadData];
    
    // 给_container赋值
    [_container reloadCardContainer];
    
}

- (void)loadData
{
    _datas = [NSMutableArray array];
    
    for (int i = 0; i < _imageArray.count; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"%@",_imageArray[i]],
                               @"name" : [NSString stringWithFormat:@"%@",_titleArray[i]]};
        NSLog(@"%@",_imageArray[i]);
        [_datas addObject:dict];
    }
}


#pragma mark -- YSLDraggableCardContainer Delegate
// 滑动view结束后调用这个方法
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection {
    
    CardView *view = (CardView *)draggableView;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effect = [[UIVisualEffectView alloc]initWithEffect:blur];
    effect.frame = view.selectedView.frame;
    [view.imageView addSubview:effect];
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionDown) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

// 更新view的状态, 滑动中会调用这个方法
- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    CardView *view = (CardView *)draggableView;
    
    //    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //    UIVisualEffectView *effect = [[UIVisualEffectView alloc]initWithEffect:blur];
    //    effect.frame = view.selectedView.frame;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        view.selectedView.backgroundColor = [UIColor redColor];
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        view.selectedView.backgroundColor = [UIColor blueColor];
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        view.selectedView.backgroundColor = [UIColor grayColor];
        view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}


// 所有卡片拖动完成后调用这个方法
- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}


// 点击view调用这个
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    
    GFWebViewViewController *webVC = [[GFWebViewViewController alloc]init];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.webUrl = self.urlArray[index];
    
    [self.navigationController wxs_pushViewController:webVC makeTransition:^(WXSTransitionProperty *transition){
        transition.animationType = WXSTransitionAnimationTypePointSpreadPresent;
        
        transition.animationTime = 1;
        transition.backGestureEnable = NO;
        transition.startView = self.view;
        
    }];
    
}

#pragma mark -- YSLDraggableCardContainer DataSource
// 根据index获取当前的view
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index {
    NSDictionary *dict = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    view.backgroundColor = [UIColor whiteColor];
    //    view.imageView.image = [UIImage imageNamed:dict[@"image"]];
    //    [view.imageView setImageURL:dict[@"image"]];
    [view.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    
    [NSString translation:dict[@"name"] CallbackStr:^(NSString * _Nonnull str) {
        view.label.text = [NSString stringWithFormat:@"%@",str];
    }];
    return view;
}
// 获取view的个数
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index {
    return _datas.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  glodFishBaseViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

@interface glodFishBaseViewController ()
//无数据背景图
@property (nonatomic,strong) UIImageView *noDataView;

@end

@implementation glodFishBaseViewController

//更新导航栏状态
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _StatusbarStyle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =KWhiteColor;
//    是否显示返回按钮
    self.isShowLiftBack = YES;
//    默认导航栏样式：黑色
    self.StatusbarStyle = UIStatusBarStyleLightContent;
//    处理导航栏遮挡问题
    
}
// 继承的类实现
- (void)showLoadingAnimation
{
    
}

- (void)stopLoadingAnimation
{
    
}

//显示无数据界面
- (void)showNoDataImage
{
    _noDataView = [[UIImageView alloc]init];
//    无数据图片
    [_noDataView setImage:[UIImage imageNamed:@""]];
    
}
// 移除没有数据的界面
- (void)removeDataImage
{
    if(_noDataView)
    {
        [_noDataView removeFromSuperview];
        _noDataView = nil;
    }
}

//懒加载tableView
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kTopHeight-kTabBarHeight) style: UITableViewStylePlain];
//        分割线 不存在偏移
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
//
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
//        头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        _tableView.backgroundColor = CViewBgColor;
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
//        布局
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kTopHeight-kTabBarHeight) collectionViewLayout:flow];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        _collectionView.mj_header = header;
        
//        底部刷新
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
       
        //#ifdef kiOS11Before
        //
        //#else
        //        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        //        _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        //#endif
        
        
        _collectionView.backgroundColor = CViewBgColor;
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}

// 只是生命具体的实现放在子类里面去实现
- (void)headerRereshing
{
    
}

- (void)footerRereshing
{
    
}
// isShowLiftBack 的set方法
- (void)setIsShowLiftBack:(BOOL)isShowLiftBack
{
    _isShowLiftBack = isShowLiftBack;
//    返回导航栏控制器控制的自控制器的个数
    NSInteger VCCount = self.navigationController.viewControllers.count;
// 判断是否显示返回按钮 当VC所在的导航栏控制器中的VC个数大于1 或者 是present出来的VC时才显示返回按钮 其他不显示
//
//    注意下这里小心可能出错
//
    if (isShowLiftBack && (VCCount >1 || self.navigationController.presentingViewController !=nil))
    {
//        添加返回按钮
        [self addNavigationItemWithImageNames:@[@"backIcon"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
    }
    else
    {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *nullBar = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = nullBar;
    }
}

//点击返回按钮
- (void)backBtnClicked
{
//    判断是否是present出来的视图
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 导航栏添加图标按钮
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    for (NSString *imageName in imageNames)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
      
//        判断在那边设置偏移量
        if (isLeft)
        {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else
        {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
//        设置btn的tag 利于回调
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        添加到items
        [items addObject:item];
    }
//    设置在左边还是在右边
    if (isLeft)
    {
        self.navigationItem.leftBarButtonItems = items;
    }
    else
    {
        self.navigationItem.rightBarButtonItems = items;
    }
}
//添加文字按钮
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    NSMutableArray *buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString *title in titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
//        设置
        if (isLeft)
        {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }
        else
        {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft)
    {
        self.navigationItem.leftBarButtonItems = items;
    }
    else
    {
        self.navigationItem.rightBarButtonItems = items;
    }
    
}


//取消请求
- (void)cancelRequest
{
    
}

# pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    当前支持的旋转类型
    return UIInterfaceOrientationMaskPortrait;
}
//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
//    默认进去的类型
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end

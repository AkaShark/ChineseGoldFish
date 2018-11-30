//
//  GFShowClassListViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowClassListViewController.h"
#import "GFShowClassCollectionViewCell.h"

#import "GFShowClassLogic.h"
#import "GFShowClassCollectionViewCell.h"
#import "MJExtension.h"
#import "GFFlowHeigh.h"
#import "UICollectionView+IndexPath.h"
#import "GFShowClassDetailViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "WXSTransitionProperty.h"

#import "FlowMenuView.h"
#import "CellDataModel.h"
#import "StartBtn.h"
#import "GFShowClassModel.h"
#import "GFShowAllCollectionViewCell.h"
#import "GFShowAllClassViewController.h"

#define itemWidthHeight ((kScreenWidth-30)/2)

@interface GFShowClassListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ShowClassDelegate>
{
    NSMutableArray  *_dataModelArray;
    NSInteger tagCount;
    NSString *_classType;
}
// 逻辑层
@property (nonatomic,strong) GFShowClassLogic *logic;
// 置顶view
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,copy) NSArray *heightArray;
@property (nonatomic,strong) FlowMenuView *headerView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;


@end

@implementation GFShowClassListViewController

- (FlowMenuView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 200) withDataModel:self->_dataModelArray[0]];
    }
    return _headerView;
}
- (NSArray *)heightArray
{
    if (!_heightArray)
    {
        _heightArray = [GFFlowHeigh mj_objectArrayWithFilename:@"shop.plist"];
    }
    return _heightArray;
}
- (GFShowClassLogic *)logic
{
    if (!_logic)
    {
        //    逻辑类初始化
         _logic = [GFShowClassLogic new];
        _logic.delegate = self;
    }
    return _logic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
   
    //不去适配导航栏
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    [self.logic requestData];
    
//    注册通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(touchTheBtn:) name:@"btn" object:nil];
    
    
}
//通知响应事件
- (void)touchTheBtn :(NSNotification *)text
{
//    冗余代码太多 抽离
    if ([text.userInfo[@"type"]  isEqual: @"cancel"])
    {
        self.logic.type = @"All"; //设置全部
        tagCount --;
        [NSString translation:@"全部品种" CallbackStr:^(NSString * _Nonnull str) {
            self.title = str;
        }];
        
        for (FlowMenuView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[FlowMenuView class]])
            {
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [view startBtn_Event];
                } completion:^(BOOL finished)
                 {
                     [self.logic requestData];
                     [self  performSelector:@selector(updateCollection) withObject:nil afterDelay:1.2];
                     
                 }];
            }
        }
    }
    else if ([text.userInfo[@"type"] isEqualToString:@"many"])
    {
//        发请求 （刷新UI）
        tagCount --;
        self.logic.type = @"manyClass";
        [NSString translation:@"经典分类" CallbackStr:^(NSString * _Nonnull str) {
            self.title = str;
        }];
        
        for (FlowMenuView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[FlowMenuView class]])
            {
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [view startBtn_Event];
                } completion:^(BOOL finished)
                 {
                     [self.logic requestData];
                     [self  performSelector:@selector(updateCollection) withObject:nil afterDelay:1.2];
                     
                 }];
            }
        }
    }
    else
    {
        tagCount --;
        self.logic.type = @"fourClass";
        [NSString translation:@"传统分类" CallbackStr:^(NSString * _Nonnull str) {
            self.title = str;
        }];
        
        for (FlowMenuView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[FlowMenuView class]])
            {
                [UIView animateWithDuration:1.0 animations:^{
                    
                    [view startBtn_Event];
                } completion:^(BOOL finished)
                 {
                     [self.logic requestData];
                     [self  performSelector:@selector(updateCollection) withObject:nil afterDelay:1.2];
                     
                 }];
            }
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSString translation:@"经典分类" CallbackStr:^(NSString * _Nonnull str) {
        self.navigationItem.title = str;
    }];
    
    tagCount = 0;
//    初始化界面
    [self setUpUI];
//    添加导航栏按钮
    [self addNavBtn];
//    加载图
}

- (void)addNavBtn
{
    //    设置导航栏按钮
    UIButton *classBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    classBtn.tag = 0;
    [NSString translation:@"切换分类" CallbackStr:^(NSString * _Nonnull str) {
        [classBtn setTitle:str forState:UIControlStateNormal];
    }];
    
    [classBtn addTarget:self action:@selector(clickClass:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:classBtn];
}


- (void)setUpUI
{
    self.view.backgroundColor = StandColor;
    _layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.headerReferenceSize = CGSizeMake(0, 310*KScreenHeight / 1900);
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    //item大小
    _layout.itemSize = CGSizeMake((KScreenWidth-50) / 2, (KScreenWidth -60) /2);
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _layout高度防止遮挡
    self.collectionView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight-64);
    [self.collectionView setCollectionViewLayout:_layout];
    self.collectionView.backgroundColor = StandColor;
//    注册
    [self.collectionView registerClass:[GFShowClassCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GFShowClassCollectionViewCell class])];
    [self.collectionView registerClass:[GFShowAllCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GFShowAllCollectionViewCell class])];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header = nil;
    self.collectionView.mj_footer = nil;
    [self.view addSubview:self.collectionView];
    
    
//    设置分类UI
    [self initSetDataArray];


    
}

//点击导航栏按钮
- (void)clickClass:(UIButton *)sender
{
    sender.enabled = NO;
    __weak __typeof__(self) weakSelf = self;
    __block FlowMenuView *headView = self.headerView;
    if (tagCount %2 == 0)
    {
        NSString *language = [[NSBundle mainBundle] preferredLocalizations][0];
        if ([language isEqualToString:@"en"])
        {
        [NSString translation:@"请选择分类方式" CallbackStr:^(NSString * _Nonnull str) {
            self.headerView.assignInfoView.assignCellView_3.numLabel.text = str;
        }];
        
        [NSString translation:@"传统分类 经典分类" CallbackStr:^(NSString * _Nonnull str) {
            self.headerView.assignInfoView.assignCellView_3.titleLabel.text = str;
        }];
        }else{
            [NSString translation:@"                请选择分类方式" CallbackStr:^(NSString * _Nonnull str) {
                self.headerView.assignInfoView.assignCellView_3.numLabel.text = str;
            }];
            
            [NSString translation:@"                传统分类 经典分类" CallbackStr:^(NSString * _Nonnull str) {
                self.headerView.assignInfoView.assignCellView_3.titleLabel.text = str;
            }];
            
        }
        
        [UIView animateWithDuration:1.0 animations:^{
            weakSelf.collectionView.frame = CGRectMake(0, 264, KScreenWidth, KScreenHeight-264);
        } completion:^(BOOL finished) {
            headView.frame = CGRectMake(0, 64, KScreenWidth, 200);
            [weakSelf.view addSubview:headView];
            [headView startBtn_Event];
            sender.enabled = YES;
        }];
    }
    else{
        [UIView animateWithDuration:1.0 animations:^{
//            headView.frame = CGRectMake(0, 64, KScreenWidth, 200);
//            [weakSelf.view addSubview:headView];
//            [headView startBtn_Event];
        } completion:^(BOOL finished)
        {
            [weakSelf performSelector:@selector(updateCollection) withObject:nil afterDelay:1.0];
            sender.enabled = YES;
        }];
    }
    tagCount ++;

}

- (void)updateCollection
{
    [UIView animateWithDuration:0.6 animations:^{
        self.collectionView.frame = CGRectMake(0, 64, KScreenWidth,KScreenHeight-64);
        [self.headerView removeFromSuperview];
    }];
   
}
// 分类动画
- (void)initSetDataArray
{
    _dataModelArray = [NSMutableArray new];
    
    [self addModel_NightLife];
}


- (void)addModel_NightLife
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr           = @"Night life";
    tempModel.imageNameStr      = @"wine";
    tempModel.followersNum      = @"517";
    tempModel.favoritesNum      = @"315";
    tempModel.viewsNum          = @"7815";
    tempModel.myColor_dark      = [UIColor colorWithHexString:@"cb5558"];
    tempModel.myColor_normal    = [UIColor colorWithHexString:@"0d9fff"];
    tempModel.myColor_light     = [UIColor clearColor];
    [_dataModelArray addObject:tempModel];
}

// 数据拉去完成渲染界面
- (void)requestDataCompleted
{
    [self.collectionView reloadData];
}

#pragma mark -deledate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.logic.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.logic.type isEqualToString:@"All"])
    {
        _layout.itemSize = CGSizeMake((KScreenWidth-50) / 3, (KScreenWidth -60) /3);
        [self.collectionView setCollectionViewLayout:_layout];
        
        GFShowAllCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GFShowAllCollectionViewCell class]) forIndexPath:indexPath];
        if (self.logic.dataArray.count >0)
        {
            cell.model = self.logic.dataArray[indexPath.row];
        }
        
        return cell;
    }
    else
    {
         _layout.itemSize = CGSizeMake((KScreenWidth-50) / 2, (KScreenWidth -60) /2);
         [self.collectionView setCollectionViewLayout:_layout];
        
        GFShowClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GFShowClassCollectionViewCell class]) forIndexPath:indexPath];
        if (self.logic.dataArray.count >0)
        {
            cell.model = self.logic.dataArray[indexPath.row];
        }
        
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.logic.type isEqualToString:@"All"])
    {
        GFShowAllClassViewController *vc = [[GFShowAllClassViewController alloc] init];
        __weak GFShowAllCollectionViewCell *cell = (GFShowAllCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        __weak GFShowAllClassViewController *weakVC = vc;
        [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition)
        {
            GFShowDetailModel *model = (GFShowDetailModel *)self.logic.dataArray[indexPath.row];
            weakVC.imageURl = model.imageUrl;
            weakVC.varityName = model.className;
            transition.animationType = WXSTransitionAnimationTypeViewMoveToNextVC;
            transition.animationTime = 0.64;
            transition.startView  = cell.showImgV;
            transition.targetView = weakVC.headImgView;
            transition.backGestureEnable = NO;
            transition.backGestureType = WXSGestureTypeNone;
        }];
    }
    else
    {
        GFShowClassCollectionViewCell *cell = (GFShowClassCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        GFShowClassDetailViewController *detailVC = [GFShowClassDetailViewController new];
        //    detailVC.
        detailVC.model = cell.model;
        detailVC.isTransitrion = YES;
        detailVC.type = self.logic.type;
        [self.navigationController wxs_pushViewController:detailVC makeTransition:^(WXSTransitionProperty *transition) {
            transition.backGestureEnable = NO;
            transition.backGestureType = WXSGestureTypeNone;
            transition.animationType = WXSTransitionAnimationTypeSysFade;
        }];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"btn" object:nil];
}


@end

//
//  GFShowClassDetailViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowClassDetailViewController.h"
#import "GFShowDetailBackImageView.h"
#import "GFShowDetailModel.h"
#import "GFShowDetaiTableViewCell.h"
#import "GFShowDetailLogic.h"
#import "GFShowDetailSectionHead.h"
#import "GFShowVarietyModel.h"

@interface GFShowClassDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

//背景图片
@property (nonatomic,strong) GFShowDetailBackImageView *headerVier;

@property (nonatomic,strong) NSMutableArray *models;

@property (nonatomic,strong) UIButton *collectionButton;
//
//@property (nonatomic,strong)NSMutableArray *collectionArray;


//@property (nonatomic,strong) NSMutableArray <NSNumber *>*cellHeight;

@end

@implementation GFShowClassDetailViewController

//- (NSMutableArray<NSNumber *> *)cellHeight
//{
//    if (!_cellHeight)
//    {
//        _cellHeight = [[NSMutableArray alloc] init];
//    }
//    return _cellHeight;
//}

-(NSMutableArray *)models
{
    if (!_models)
    {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    GFShowDetailLogic *logic = [GFShowDetailLogic new];
//    传参数
    logic.className = _model.className;
    logic.type = self.type;
    
    [logic requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateTheUI:) name:@"dataComplicetion" object:nil];
    
    
     //收藏按钮
    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectionButton setImage:[UIImage imageNamed:@"白心"] forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:@"红心"] forState:UIControlStateSelected];
    [_collectionButton setFrame:CGRectMake(0, 0, 30, 30)];
    [_collectionButton addTarget:self action:@selector(addCollect:) forControlEvents:UIControlEventTouchUpInside];
    if ([self getDicInDefault])
    {
        _collectionButton.selected = YES;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_collectionButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//点击事件
- (void)addCollect:(UIButton *)sender{
    
  
    NSArray *defaultArray = [self getUserDefautle];
    NSMutableArray *willSaveArray;
    if (defaultArray.count == 0) {
        willSaveArray = [[NSMutableArray alloc] init];
    }else{
    willSaveArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    if (sender.selected == NO)
    {
//        设置btn的状态
        [NSString translation:@"收藏成功，请到“我的收藏”查看" CallbackStr:^(NSString * _Nonnull str) {
            [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeSuccess];
        }];
//        [[HUDTA new] showHudWithStr:@"收藏成功，请到“我的收藏”查看" AndOption:TAOverlayOptionOverlayTypeSuccess];
        sender.selected = YES;
          //        存储
        [self saveToDefaultWith:willSaveArray];
    
    }else if (sender.selected == YES) {
        [NSString translation:@"取消收藏成功" CallbackStr:^(NSString * _Nonnull str) {
            [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
        }];
//        [[HUDTA new] showHudWithStr:@"取消收藏成功" AndOption:TAOverlayOptionOverlayTypeError];
        sender.selected = NO;
//        删除
        [self delegateDefault:willSaveArray];
    }

}

#pragma mark- UserDefault操作
// 获取default
- (NSArray *)getUserDefautle
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //取出
    NSArray *defaultArray = [user objectForKey:@"collection"];
    return defaultArray;
}

//判断btn状态
- (NSDictionary *)getDicInDefault
{
    NSArray *defaultArray = [self getUserDefautle];
    for (NSDictionary *dic in defaultArray)
    {
        if ([dic[@"name"] isEqualToString:_model.className])
        {
            return dic;
        }
    }
    return nil;
}

// 存储
- (void)saveToDefaultWith: (NSMutableArray *)willSaveArray
{
    //        归档操作
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: _model];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:data forKey:@"model"];
    [dic setObject:_type forKey:@"type"];
    [dic setObject:_model.className forKey:@"name"];
    [willSaveArray addObject:dic];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:(NSArray *)willSaveArray forKey:@"collection"];
    [defaults synchronize];
}
// 删除
- (void)delegateDefault:(NSMutableArray *)willSaveArray
{
    NSDictionary *dic = [self getDicInDefault];
    [willSaveArray removeObject:dic];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:(NSArray *)willSaveArray forKey:@"collection"];
    [defaults synchronize];
}

#pragma mark -UI设置

// KVO监听
- (void)upDateTheUI:(NSNotification *)notification
{
    self.models = notification.object;
//   刷新tableView
    [self.tableView reloadData];
    
}
//头部视图
- (void)setUpHeadView
{
    //    headerView
    _headerVier = [[GFShowDetailBackImageView alloc] init];
//    自动布局也要设置大小 然后去ifneedlayout 刷新大小
    _headerVier.frame = CGRectMake(0, 0, KScreenWidth, 500);
    [_headerVier setUpUI:self.model.imageUrl AndDetail:self.model.detailStr ClassName:self.model.className];
}

-(void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    预设高度
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 25, 0, 25)];
    [self.tableView.tableHeaderView layoutIfNeeded];
    [self.view addSubview:self.tableView];
    //头部视图
    [self setUpHeadView];
    self.tableView.tableHeaderView = _headerVier;
}

# pragma mark - tableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.models.count > 0)
    {
        return _models.count-1;
    }
    else
    {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFShowDetaiTableViewCell *cell = [[GFShowDetaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailTableViewCell"];
    if (!cell)
    {
        cell = [[GFShowDetaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailTableViewCell"];
    }
    cell.model = self.models[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 不用设置高度 利用自动布局 关于cell的布局错误是由于在设置cell的时候先去返回44再去约束就产生了冲突的结果

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GFShowDetailSectionHead *sectionHead = [[GFShowDetailSectionHead alloc] init];
    sectionHead.frame = CGRectMake(0, 0, KScreenWidth, 25);
    GFShowVarietyModel *model = self.models[section];
    [sectionHead setUpDataImageUrl:@"fishTitle" vartiyName:model.varietyName];
    
    return sectionHead;
}

//固定头部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float luochaY = 399 - 64;
    CGFloat offSetY = scrollView.contentOffset.y;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    CGPoint offset = scrollView.contentOffset;
    [_headerVier whenScrollGetOffset:offset];
    
    
    if (offSetY <= 0)
    {
        self.title = @"";
        self.navigationController.navigationBar.alpha = 1;
        //    //设置导航栏背景图片为一个空的image，这样就透明了
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    } else if (offSetY > luochaY-64)
    {
        self.navigationController.navigationBar.alpha = 1;
        [NSString translation:_model.className CallbackStr:^(NSString * _Nonnull str) {
            self.title = str;
        }];
    }
    else{
        self.title = @"";
        self.navigationController.navigationBar.alpha = offSetY / luochaY;
    }
    
    
    
//    @339
//    在悬停位置view变成0
    CGFloat sectionHeaderHeight = 25;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


//移除监听
- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end

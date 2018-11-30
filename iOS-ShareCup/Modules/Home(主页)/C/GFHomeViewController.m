//
//  GFHomeViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFHomeViewController.h"
#import "GFHomeFlowView.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "GFHomeMiddleTableViewCell.h"
#import "GFHomeBottomTableViewCell.h"
#import "UINavigationController+WXSTransition.h"
#import "GFWebViewViewController.h"
#import "GFHistoryViewController.h"
#import "GFBreedViewController.h"
#import "GFShowClassListViewController.h"
#import "GFLoginViewController.h"
#import "GFShowAllImageViewController.h"
#import "YNTopPageVC.h"
#import "GFShowDocumentTableViewCell.h"
#import "GFShowDocumentViewController.h"
#import "GFCameraHandler.h"
#import "UIImage+Base64Encoding.h"
#import "GFRecongitionViewController.h"
#import "GFNewGudieViewController.h"

/**
 轮播图在使用了背景模糊中 造成拉顿的问题
 */
@interface GFHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL first;
}
// 功能数组
@property (nonatomic,strong) NSArray *funcArray;

@property (nonatomic,strong) GFHomeFlowView *headView;
//随机数组
//@property (nonatomic,copy) NSArray *newsArray;

@property (nonatomic,copy) NSArray *sectionHeadTitle;

@property (nonatomic,strong) GFNewGudieViewController *guide;

//nestitleArray
//@property (nonatomic,copy) NSArray *newsTitle;
//@property (nonatomic,copy) NSArray *newsImage;
//@property (nonatomic,copy) NSArray *newsUrl;

@end


@implementation GFHomeViewController

- (NSArray *)sectionHeadTitle
{
    if (!_sectionHeadTitle)
    {
        _sectionHeadTitle = @[@"disease",@"strain",@"tools"];
    }
    return _sectionHeadTitle;
}

- (NSArray *)funcArray
{
    if (!_funcArray)
    {
        _funcArray = @[@"2",@"2",@"2",@"2",@"2"];
    }
    return _funcArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    first = YES;
    
    [self getRequestData];
//    //不去适 配导航栏
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    //设置打开抽屉模式
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    //    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//请求数据
- (void)getRequestData
{
//    int x = arc4random() % 3;
//    [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFishData.php?type=%@",self.newsArray[x]] parameters:nil succeed:^(id responseObject) {
//        NSDictionary *result = (NSDictionary *)responseObject[@"result"];
//        self.newsTitle = result[@"title"];
//        self.newsImage = result[@"image"];
//        self.newsUrl = result[@"url"];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    } failure:^(NSError *error) {
//
//    }];
//
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageStrArray = [NSArray arrayWithObjects:@"book",@"literature",@"video",nil];
    
    [self mainUIStup];
    
    
    BOOL isGudied = [[NSUserDefaults standardUserDefaults] boolForKey:@"newGuided"];
    if (!isGudied)
    {
        _guide = [[GFNewGudieViewController alloc] initWithNibName:@"GFNewGudieViewController" bundle:[NSBundle mainBundle]];
        _guide.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        _guide.view.backgroundColor = StandBackColor;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        __weak typeof(self) weakSelf = self;
        [window addSubview:_guide.view];
        _guide.callBack = ^{
            [weakSelf.guide.view removeFromSuperview];
            weakSelf.guide = nil;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"newGuided"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        };
        
    }
    
   
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
- (void)mainUIStup
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-44) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setHeadView];
    [self NavBtn];
    
}

- (void)NavBtn
{
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    leftDrawerButton.tintColor = [UIColor whiteColor];
    // 设置背景图片
    //    leftDrawerButton.image =
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self action:@selector(clickTheSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"discriminate"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

//点击搜索按钮
- (void)clickTheSearchBtn:(UIButton *)sender
{
    [[GFCameraHandler shareHandler] showCameraPickerInController:self finishBlock:^(UIImage *originImage) {
        GFRecongitionViewController *reVC = [[GFRecongitionViewController alloc] init];
        reVC.image = originImage;
        
//        识别 获取token
        NSString *encodedImageStr = [UIImage imageBaseEncodeWithimage:originImage];
        
        NSDictionary *dic = @{@"image":encodedImageStr,
                              @"top_num":@6,
                              @"baike_num":@6
                              };
        
        [POST_GET POSTBaiDu:@"https://aip.baidubce.com/rest/2.0/image-classify/v1/animal?access_token=24.3b5331780e835502096cbf532270ba51.2592000.1543719201.282335-14648170" parameters:dic success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            NSArray *resultArray = responseObject[@"result"];
            NSMutableArray *nameArray = [[NSMutableArray alloc] init];
            NSMutableArray *scoreArray = [[NSMutableArray alloc] init];
            NSMutableArray *urlArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in resultArray)
            {
                [nameArray addObject:dic[@"name"]];
                [scoreArray addObject:dic[@"score"]];
                NSDictionary *dict = dic[@"baike_info"];
                if ([[dict allKeys] containsObject:@"baike_url"]) {
                    [urlArray addObject:dict[@"baike_url"]];   
                }
                
            }
            [nameArray addObject:@"关闭"];
            [scoreArray addObject:@"0"];
            reVC.nameArray = nameArray;
            reVC.scoreArray = scoreArray;
            reVC.urlArray = urlArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenHud" object:nil];
                
                [[UIApplication sharedApplication].delegate.window addSubview:reVC.view];
            });
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
       
        
    }];
    
}
//点击开启侧滑
- (void)leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
//设置头部
- (void)setHeadView
{
    _headView = [[GFHomeFlowView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 230)];
    self.tableView.tableHeaderView = self.headView;
}



#pragma mark - TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        GFHomeMiddleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"middleCell"];
        if (!cell)
        {
            cell = [[GFHomeMiddleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"middleCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.callBack = ^(NSInteger tag) {
            NSLog(@"%ld",tag);
            if(tag == 0)
            {
                GFHistoryViewController *vc =  [GFHistoryViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                //            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeCover];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (tag == 1)
            {
                GFShowClassListViewController *vc =  [GFShowClassListViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                //            [self.navigationController wxs_pushViewController:vc animationType:WXSTransitionAnimationTypeCover];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if (tag == 2)
            {
                GFBreedViewController *breed = [[GFBreedViewController alloc]init];
                breed.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:breed animated:YES];
            }
            else if (tag == 3)
            {
                GFShowAllImageViewController *image = [[GFShowAllImageViewController alloc] init];
                image.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:image animated:YES];
                
            }
        };
        return cell;
    }
    else
    {
        GFShowDocumentTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"bottomCell"];
        if (!cell)
        {
            cell = [[GFShowDocumentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bottomCell"];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = 15;
        cell.layer.masksToBounds = YES;
        //        更新数据
        [cell setUIDataTitleStr:@"" andImageStr:_imageStrArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 3;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        return 161.0f;
    }else
        return 220.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    else{
        return 0;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHead = [[UIView alloc] init];
    
    UIImageView *headIconImgV = [[UIImageView alloc] init];
    headIconImgV.image = [UIImage imageNamed:@"WiKi"];
    headIconImgV.frame = CGRectMake(25, 16, 20, 20);
    [sectionHead addSubview:headIconImgV];
    
    
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont systemFontOfSize:23 weight:UIFontWeightRegular];
    
    [NSString translation:@"金鱼百科" CallbackStr:^(NSString * _Nonnull str) {
        titleLbl.text = str;
    }];
    titleLbl.frame = CGRectMake(50, 0, 200, 50);
    [sectionHead addSubview:titleLbl];
    
    if (section == 0)
    {
        return [[UIView alloc] init];
    }
    else
    {
        return sectionHead;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]init];
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.frame = CGRectMake(0, 50, KScreenWidth, 20);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    titleLbl.textColor = [UIColor lightGrayColor];
    titleLbl.text = @"继续下拉查看金鱼资讯";
    [footer addSubview:titleLbl];

    if (section == 0)
    {
        return [[UIView alloc] init];
    }
    else
    {
        return footer;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        GFShowDocumentViewController *doucumentVC = [[GFShowDocumentViewController alloc] init];
        doucumentVC.type = _imageStrArray[indexPath.row];
        doucumentVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController wxs_pushViewController:doucumentVC makeTransition:^(WXSTransitionProperty *transition) {
            transition.animationType = WXSTransitionAnimationTypeBrickOpenHorizontal;
            transition.backGestureEnable = NO;
            transition.autoShowAndHideNavBar = NO;
        }];
    }
    
}

//监听滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
  if(self.tableView.contentOffset.y > KScreenHeight-50 && first)
  {
      YNTopPageVC *vc = [YNTopPageVC topPageVC];
      vc.hidesBottomBarWhenPushed = YES;
      [self.navigationController wxs_pushViewController:vc makeTransition:^(WXSTransitionProperty *transition) {
          transition.animationType = WXSTransitionAnimationTypeBrickCloseVertical;
          transition.backGestureEnable = NO;
      }];
      first = NO;
  }

    if (scrollView == self.tableView)
    {
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 50;
        CGFloat sectionFooterHeight = 50;
        CGFloat offsetY = tableview.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
        {
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }
    }
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





@end

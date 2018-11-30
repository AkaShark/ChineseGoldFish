//
//  GFSildViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 09/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFSildViewController.h"
#import "GFSideWaterView.h"
#import "CALeftWeatherView.h"
//#import "CACollectionTableViewController.h"
#import "CASettingTableViewController.h"
#import "SYSuggestionViewController.h"
#import "AXHCollectionViewController.h"
#import "GFMyCollectionViewController.h"
#import <StoreKit/StoreKit.h> // 评分库

#import "UIViewController+MMDrawerController.h"

@interface GFSildViewController ()<UITableViewDelegate,UITableViewDataSource,SKStoreProductViewControllerDelegate>

@end

@implementation GFSildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setupTableView];
   
    [self createWater];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"silder"]];
}

- (void)setupTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-100, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
}

- (void)createWater
{
    GFSideWaterView *waterView = [GFSideWaterView new];
    waterView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:waterView];
    [waterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    [self.view layoutIfNeeded];
    
    [self.view setNeedsLayout];
    
    [waterView setWave];
    
    waterView.callBack = ^(NSInteger tag) {
        if (tag == 0)
        {
            //            点击夜间
            
        }
        else
        {
            //            点击二维码
            
        }
    };
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"";
    } else if (indexPath.row == 1) {
        [NSString translation:@"我的收藏" CallbackStr:^(NSString * _Nonnull str) {
             cell.textLabel.text = str;
        }];
    } else if (indexPath.row == 2) {
        [NSString translation:@"应用设置" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
    } else if (indexPath.row == 3) {
        [NSString translation:@"意见反馈" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
    } else if (indexPath.row == 4) {
        [NSString translation:@"关于我们" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
    } else if (indexPath.row == 5){
        [NSString translation:@"评分" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
    }
    else{
//        cell.textLabel.text = @"引导页";
    }
    
    return cell;
}
//设置头部view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //调用头部视图
    CALeftWeatherView *weather = [[CALeftWeatherView alloc] init];
    weather.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return weather;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 230;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
//        CACollectionTableViewController *pushVC = [[CACollectionTableViewController alloc] init];
//        pushVC.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
//        [self pushViewController:pushVC];
    } else if (indexPath.row == 1) {
        GFMyCollectionViewController *collectionVC = [[GFMyCollectionViewController alloc]init];
        
        collectionVC.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        [self pushViewController:collectionVC];
        
    } else if (indexPath.row == 2) {
        CASettingTableViewController *caTableView = [[CASettingTableViewController alloc] init];
        caTableView.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self pushViewController:caTableView];
    } else if (indexPath.row == 3) {
        //意见反馈
        SYSuggestionViewController *pushVC = [[SYSuggestionViewController alloc] init];
        pushVC.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self pushViewController:pushVC];
       
    }else if (indexPath.row == 4){
        //关于我们
        AXHCollectionViewController *pushVC = [[AXHCollectionViewController alloc] init];
        pushVC.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self pushViewController:pushVC];
    }
    else if (indexPath.row == 5)
    {
        
        //评分
        [self openAppWithIdentifier:@"1296828027"];
        
        
        
//        NSLog(@"引导页");
//        LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[@"智能检索",@"数据分析",@"地图分布"]andWant:YES];
//        launch.currentColor = standardGreen;
//        launch.nomalColor = [UIColor whiteColor];
        
    }
    
    
}
-(void)pushViewController:(UIViewController *)pushVC{
    UITabBarController * nav = (UITabBarController*)self.mm_drawerController.centerViewController;
    pushVC.hidesBottomBarWhenPushed = YES;
    UINavigationController *vc = nav.viewControllers[nav.selectedIndex];
    [vc pushViewController:pushVC animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
    
}

/**
 * 实例化一个SKStoreProductViewController类 -- 评分    用
 */
- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



@end

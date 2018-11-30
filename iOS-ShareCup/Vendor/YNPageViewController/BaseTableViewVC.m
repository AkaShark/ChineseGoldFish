//
//  BaseVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "BaseTableViewVC.h"
#import "MJRefresh.h"
#import "GFWebViewViewController.h"
#import "UIViewController+YNPageExtend.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 0

#define kCellHeight 120

@interface BaseTableViewVC () <UITableViewDataSource, UITableViewDelegate>


/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;

@end

@implementation BaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[GFHomeBottomTableViewCell class] forCellReuseIdentifier:@"id"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self.view addSubview:self.tableView];
    
}

//#pragma mark - 悬浮Center刷新高度方法
//- (void)suspendTopReloadHeaderViewHeight {
//    /// 布局高度
//    CGFloat netWorkHeight = 300;
//    __weak typeof (self) weakSelf = self;
//
//    /// 结束刷新时 刷新 HeaderView高度
//    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
//        YNPageViewController *VC = weakSelf.yn_pageViewController;
//        if (VC.headerView.frame.size.height != netWorkHeight) {
//            VC.headerView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
//            [VC reloadSuspendHeaderViewFrame];
//        }
//    }];
//}
//#pragma mark - 求出占位cell高度
//- (CGFloat)placeHolderCellHeight {
//    CGFloat height = self.config.contentHeight - kCellHeight * self.modelArray.count;
//    height = height < 0 ? 0 : height;
//    return height;
//}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.row < self.modelArray.count) {
//        return kCellHeight;
//    }
//    return self.placeHolderCellHeight;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GFHomeBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell upDataTheData:((GFNewsModel *)self.modelArray[indexPath.row]).imageUrl title:((GFNewsModel *)self.modelArray[indexPath.row]).titleStr andDetail:((GFNewsModel *)self.modelArray[indexPath.row]).detailStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFWebViewViewController *web = [[GFWebViewViewController alloc] init];
    web.webUrl = ((GFNewsModel *)self.modelArray[indexPath.row]).contentURl;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    上拉跳转
    if (self.tableView.contentOffset.y < -100)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, KScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}

@end

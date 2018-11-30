//
//  GlodFishViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GlodFishViewController.h"
#import "UTPinYinHelper.h"
#import "GFShowAllClassViewController.h"

@interface GlodFishViewController ()<PYSearchViewControllerDelegate>

@property (nonatomic,copy) NSArray *namesClass;
@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) NSMutableArray *hotArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation GlodFishViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [POST_GET GET:@"http://47.104.211.62/GlodFish/glodFishAll.php?all=1"parameters:nil succeed:^(id responseObject) {
        self.namesClass = responseObject[@"result"][@"ClassName"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [POST_GET GET:@"http://47.104.211.62/GlodFish/glodFishAll.php?all=2"parameters:nil succeed:^(id responseObject) {
        self.hotArray = responseObject[@"result"][@"ClassName"];
        self.imageArray  = responseObject[@"result"][@"image"];
        self.hotAdArray = self.hotArray;
        self.hotImage = self.imageArray;
        //    发送通知 通知collection显示刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hotAdArray" object:nil];
   
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}

#pragma mark- delegate

/** 搜索框文本变化时，显示的搜索建议通过searchViewController的searchSuggestions赋值即可 */
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)searchBar searchText:(NSString *)searchText
{
//    移除全部元素
    [self.resultArray removeAllObjects];
    
    if (searchText!=nil && searchText.length>0)
    {
        NSLog(@"%@",searchText);
        [self.namesClass enumerateObjectsUsingBlock:^(NSString *strName, NSUInteger idx, BOOL *stop) {
            UTPinYinHelper *pinYinHelper = [UTPinYinHelper sharedPinYinHelper];
//            判断一个字符串与要查询的字符串是否匹配
            if ([pinYinHelper isString:strName MatchsKey:searchText IgnorCase:YES])
            {
                [self.resultArray addObject:strName];
            }
        }];
        NSSet *set = [NSSet setWithArray:self.resultArray];
        searchViewController.searchSuggestions = (NSArray *)[set allObjects];
        [searchViewController.searchSuggestionView reloadData];
    }
    else
    {
        searchViewController.searchSuggestions = nil;
    }
    
  
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

// 点击历史搜索
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText
{
    searchText = [searchText stringByReplacingOccurrencesOfString:@"," withString:@""];
    GFShowAllClassViewController *vc = [[GFShowAllClassViewController alloc] init];
    vc.varityName = searchText;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//点击列表的搜索 、、 
- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectSearchSuggestionAtIndexPath:(NSIndexPath *)indexPath searchBar:(UISearchBar *)searchBar
{
    GFShowAllClassViewController *vc = [[GFShowAllClassViewController alloc] init];
//    判断是否村存在
    vc.varityName = searchBar.text;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)resultArray
{
    if (!_resultArray)
    {
        _resultArray = [[NSMutableArray alloc] init];
    }
    return _resultArray;
}

@end

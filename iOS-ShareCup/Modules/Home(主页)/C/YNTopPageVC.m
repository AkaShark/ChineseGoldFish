//
//  YNTopPageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNTopPageVC.h"
#import "BaseTableViewVC.h"
#import "GFNewsModel.h"

@interface YNTopPageVC () <YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@end

@implementation YNTopPageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    没有导航条的情况下
    self.view.backgroundColor = [UIColor colorWithHexString:@"#158AFF"];
     [self setStatusBarBackgroundColor:[UIColor colorWithHexString:@"#158AFF"]];
 [self.navigationController setNavigationBarHidden:YES animated:animated];
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    kvc
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    选择器选择方法
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
}

+ (instancetype)topPageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleTop;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = NO;
    configration.converColor = UIColorHex(@"e6e6e6");
    
    YNTopPageVC *vc = [YNTopPageVC pageViewControllerWithControllers:[self getArrayVCs]
                                                              titles:[self getArrayTitles]
                                                              config:configration];
    
    vc.dataSource = vc;
    vc.delegate = vc;
    
    
    return vc;
}


+ (NSArray *)getArrayVCs {
    
    BaseTableViewVC *vc_1 = [[BaseTableViewVC alloc] init];
    [NSString translation:@"金鱼品系"
              CallbackStr:^(NSString * _Nonnull str) {
                  vc_1.cellTitle = str;
              }];
    
    BaseTableViewVC *vc_2 = [[BaseTableViewVC alloc] init];
    [NSString translation:@"养鱼器具"
              CallbackStr:^(NSString * _Nonnull str) {
                  vc_2.cellTitle = str;
              }];
    
    BaseTableViewVC *vc_3 = [[BaseTableViewVC alloc] init];
    [NSString translation:@"防治鱼病"
              CallbackStr:^(NSString * _Nonnull str) {
                  vc_3.cellTitle = str;
              }];
    
    return @[vc_1, vc_2, vc_3];
}

+ (NSArray *)getArrayTitles {
    return @[@"金鱼品系", @"养鱼器具", @"防治鱼病"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

+(NSArray *)getTypeArray
{
    NSArray *array = @[@"strain",@"tools",@"disease"];
    return array;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index
{
    BaseTableViewVC *baseVC = pageViewController.controllersM[index];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("cellData", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFishData.php?type=%@",[YNTopPageVC getTypeArray][index]] parameters:nil succeed:^(id responseObject) {
            NSDictionary *dict = (NSDictionary *)responseObject[@"result"];
            NSArray *urlArray = dict[@"url"];
            NSArray *imageArray = dict[@"image"];
            NSArray *titleArray = dict[@"title"];
            NSArray *detailArray = dict[@"detail"];
            
            for (int i =0; i < urlArray.count; i++)
            {
                GFNewsModel *model = [[GFNewsModel alloc] init];
                model.titleStr = titleArray[i];
                model.detailStr = detailArray[i];
                model.imageUrl = imageArray[i];
                model.contentURl = urlArray[i];
                [dataArray addObject:model];
            }
            baseVC.modelArray = dataArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [baseVC.tableView reloadData];
            });
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    });
   
    return [baseVC tableView];
}

@end

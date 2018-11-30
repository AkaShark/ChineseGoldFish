//
//  GFShowDocumentViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/21.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDocumentViewController.h"
#import "GFDownloadDocumentTableViewCell.h"
#import "GFDownLoadManager.h"
#import "ReaderViewController.h"
#import "UINavigationController+WXSTransition.h"
#import "GFVideoListTableViewCell.h"
#import <TTAVPlayer/TTAVPlayer.h>

//#define GFIsDownLoad(x) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"%@_isDownLoad.data",x]

@interface GFShowDocumentViewController ()<TTAVPlayerViewDelegate,ReaderViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSArray *listArray;
@property (nonatomic,copy) NSString *rount;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) NSMutableDictionary *alreadDic;

@property (nonatomic,strong) TTAVPlayerView *playerView;

@property (nonatomic,strong) TTAVPlayerVideoInfo *videoInfo;

@property (nonatomic,assign) BOOL showBar;

@end

@implementation GFShowDocumentViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestData];
    
//    //    不去适配
//    if (@available(iOS 11.0, *)){
//
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
  
    
}
//请求数据
- (void)requestData
{
    [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/getDOucumentList.php?type=%@",_type] parameters:nil succeed:^(id responseObject) {
        self.listArray = (NSArray *)responseObject[@"result"][@"doucument"];
        self.rount = (NSString *)responseObject[@"result"][@"rount"];
        [self.rount stringByReplacingOccurrencesOfString:@"." withString:@""];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //    不去适配
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    NSString *title = [NSString string];
    
    if([_type isEqualToString:@"book"])
    {
        [NSString translation:@"图书" CallbackStr:^(NSString * _Nonnull str) {
          __block title = str;
        }];
    }
    else if ([_type isEqualToString:@"literature"])
    {
        [NSString translation:@"文献" CallbackStr:^(NSString * _Nonnull str) {
          __block  title = str;
        }];
    }
    else
    {
        [NSString translation:@"视频" CallbackStr:^(NSString * _Nonnull str) {
           __block title = str;
        }];
    }
    [NSString translation:@"列表" CallbackStr:^(NSString * _Nonnull str) {
        self.title = [NSString stringWithFormat:@"%@%@",title,str];
    }];
   
    [self setUpUI];
}

- (void)setUpUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
//    网络状态判断
    [[GFDownLoadManager detaultManager] nowStateOfNet:^(NSString * _Nonnull state) {
        NSLog(@"%@",state);
    }];
    
//   获取当前网速 这一秒减去上一秒
    
}

#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self.listArray isKindOfClass:[NSNull class]])
    {
        return self.listArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_type isEqualToString:@"book"] || [_type isEqualToString:@"literature"])
    {
        GFDownloadDocumentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doucumentCell"];
        if (!cell)
        {
            cell = [[GFDownloadDocumentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"doucumentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //    判断是否下载 不可以 存在问题
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic = [defaults objectForKey:_type];
        NSString *str = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        if (str && [str containsString:@"yes"])
        {

            [cell finishDownLoadDoucment:@"下载完成" Name:_listArray[indexPath.row]];
            
            self.alreadDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            return cell;
        }
        
        //    没有下载的情况
//        [NSString translation:@"下载查看" CallbackStr:^(NSString * _Nonnull str) {
//            [cell setDataisLoadingStr:str Progress:self.progress Name:self.listArray[indexPath.row] Speed:@"0k/s"];
//        }];
        [cell setDataisLoadingStr:@"下载查看" Progress:self.progress Name:self.listArray[indexPath.row] Speed:@"0k/s"];
        
        NSString *rount = [self.rount stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString *url = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish%@/%@",rount,self.listArray[indexPath.row]];
        
        
        
        //    转utf8
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        __weak typeof(cell) WeakCell = cell;
        __weak typeof(self) WeakSelf = self;
        //    点击下载
        
        cell.downloadTheDoucument = ^{
            [[GFDownLoadManager detaultManager] downloadFromURL:url progress:^(CGFloat downloadProgress,NSString *speed) {
                //            NSLog(@"%@",speed);
//                [NSString translation:@"正在下载" CallbackStr:^(NSString * _Nonnull str) {
//                    [WeakCell isDowningTheDoucument:str Speed:speed Progress:downloadProgress];
//                }];
                [WeakCell isDowningTheDoucument:@"正在下载" Speed:speed Progress:downloadProgress];
                
            } complement:^(NSString * _Nonnull filePath, NSError * _Nonnull error) {
                
                //            [WeakSelf.filePath setValue:filePath forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                
//                [NSString translation:@"下载完成" CallbackStr:^(NSString * _Nonnull str) {
//                   [WeakCell finishDownLoadDoucment:str Name:WeakSelf.listArray[indexPath.row]];
//                }];
                
                [WeakCell finishDownLoadDoucment:@"下载完成" Name:WeakSelf.listArray[indexPath.row]];
                
                
                //标记下载完成 注意看拼接
                [self.alreadDic setObject:[NSString stringWithFormat:@"%@_yes-%@",WeakSelf.type,filePath] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            }];
            
        };
        
        return cell;
    }
    else
    {
        GFVideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VidelCell"];
        if (!cell)
        {
            cell = [[GFVideoListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VidelCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        NSRange range = [self.listArray[indexPath.row] rangeOfString:@"."];
        //       取出名字
        NSString *nameStr = [self.listArray[indexPath.row] substringToIndex:range.location];
        [cell setHeadImage:@"videoImage" Name:nameStr];
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_type isEqualToString:@"book"] || [_type isEqualToString:@"literature"])
    {
//    判断是否下载了
    NSString *str = [self.alreadDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (str && [str containsString:@"yes"])
    {
//        这样改体验不好 应该从下载那个改直接返回md5+pdf OK 简单粗暴
        NSRange range = [str rangeOfString:@"Caches/"];//匹配得到的下标
        NSString *fileName = [str substringFromIndex:range.location+7];
//        获取到chace的位置
        NSString *chachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",chachePaths,fileName];
        
//        判断文件是否存在
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:filePath])
        {
            
            //        push到PDF界面
                    ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:filePath password:nil];
                    ReaderViewController *rvc = [[ReaderViewController alloc] initWithReaderDocument:doc];
                    rvc.delegate = self;
                    [self.navigationController wxs_pushViewController:rvc makeTransition:^(WXSTransitionProperty *transition) {
                        transition.backGestureEnable = NO;
                        transition.animationType = WXSTransitionAnimationTypeInsideThenPush;
                        transition.autoShowAndHideNavBar = NO;
                    }];
//                    [self.navigationController pushViewController:rvc animated:YES];
        }
    }
    
    }
    else{
//        取出路径
        NSString *rount = [self.rount stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSString *url = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish%@/%@",rount,self.listArray[indexPath.row]];
        //    转utf8
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSRange range = [self.listArray[indexPath.row] rangeOfString:@"."];
        //       取出名字
        NSString *nameStr = [self.listArray[indexPath.row] substringToIndex:range.location];
        
        self.videoInfo.videoUrl = url;
        self.videoInfo.videoTitle = nameStr;
        
        _playerView = [[TTAVPlayerView alloc]initWithFrame:CGRectMake(0.0f, 0, KScreenWidth, KScreenHeight) withVideoInfo:self.videoInfo withViewMode:TTAVPlayerViewPortraitMode];
        _playerView.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_playerView];
        [_playerView play];
        
        
    }
    
}

#pragma mark- 播放代理
- (void)onVideoFullScreen
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)videoDidPause
{
   [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark - ReaderViewControllerDelegate 点击done
- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (TTAVPlayerVideoInfo *)videoInfo
{
    if (!_videoInfo)
    {
         _videoInfo = [[TTAVPlayerVideoInfo alloc]init];
    }
    return _videoInfo;
}
- (NSArray *)listArray
{
    if (!_listArray)
    {
        _listArray = [[NSArray alloc] init];
    }
    return _listArray;
}
- (NSMutableDictionary *)alreadDic
{
    if (!_alreadDic)
    {
        _alreadDic = [[NSMutableDictionary alloc] init];
    }
    return _alreadDic;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    返回则结束 。。。 有待优化。。。卡死线程是因为上一个task没有结束 设置返回还在下载做成离线下载的样子 可以实现后台下载但是在界面的实现上面有些问题a
    [[GFDownLoadManager detaultManager] cancelAllTasks];
    
    if (self.alreadDic.allKeys.count > 0)
    {
        ////    保存单例 错误 non-property-list https://juejin.im/post/5adf1831518825673b61aa65
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@",self.alreadDic);
//        USerdefaults存储的时候不可以存储可变的对象
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.alreadDic];
        [defaults setObject:dict forKey:_type];
        [defaults synchronize];
    }
    else
    {
        
    }

}

@end

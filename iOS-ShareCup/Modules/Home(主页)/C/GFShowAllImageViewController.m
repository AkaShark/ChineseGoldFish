//
//  GFShowAllImageViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowAllImageViewController.h"
#import "UIImageView+WebCache.h"
#import "GFShowAllImageCollectionViewCell.h"
#import "GFShowImageModel.h"
#import "MSSCollectionViewCell.h"
#import "GFShowImageMssViewController.h"
@interface GFShowAllImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation GFShowAllImageViewController


- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

// 请求数据
- (void)requestData
{
    [POST_GET GET:@"http://47.104.211.62/GlodFish/glodFishImages.php" parameters:nil succeed:^(id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *titleArray = dict[@"result"][@"contentTitle"];
        NSArray *contentArray = dict[@"result"][@"contentUrl"];
        NSArray *imageArray = dict[@"result"][@"images"];
        for (int i =0 ; i<titleArray.count; i++)
        {
            GFShowImageModel *model = [[GFShowImageModel alloc] init];
            model.contentUrl = contentArray[i];
            model.contentTitle = titleArray[i];
            model.images = imageArray[i];
            [self.dataArray addObject:model];
        }
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    [NSString translation:@"金鱼图鉴" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCollection];
}

- (void)createCollection
{
    self.view.backgroundColor = StandColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:layout];
    
//        layout.headerReferenceSize = CGSizeMake(0, 310*KScreenHeight / 1900);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    //item大小
    layout.itemSize = CGSizeMake((KScreenWidth-50) / 2, (KScreenWidth -60) /2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.collectionView registerClass:[GFShowAllImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GFShowAllImageCollectionViewCell class])];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
}

#pragma makr - UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFShowAllImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GFShowAllImageCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    进入图片浏览器
    // 加载网络图片
    NSString *images = ((GFShowImageModel *)_dataArray[indexPath.item]).images;
    NSArray *imageArray = [images componentsSeparatedByString:@","];
    GFShowImageMssViewController *VC = [[GFShowImageMssViewController alloc] init];
    VC.imageArray = (NSMutableArray *)imageArray;
    VC.titleStr =((GFShowImageModel *)_dataArray[indexPath.item]).contentTitle;
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end

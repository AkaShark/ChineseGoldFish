//
//  GFShowImageMssViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/7.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowImageMssViewController.h"
#import "MSSCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MSSBrowseDefine.h"
@interface GFShowImageMssViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate>

@end

@implementation GFShowImageMssViewController


- (void)viewWillAppear:(BOOL)animated
{
//移除一个
    [self.imageArray removeLastObject];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSString translation:self.titleStr CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    
    [self setUpUI];
}

- (void)setUpUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
//    //cell注册
    [self.collectionView registerClass:[MSSCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCollectionViewCell" forIndexPath:indexPath];
    if (cell)
    {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.row]]placeholderImage:[UIImage imageNamed:@"noDataImage"]];
        cell.imageView.tag = indexPath.row + 100;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
    }
    return cell;
}

//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [self.imageArray count];i++)
    {
        UIImageView *imageView = [self.view viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = self.imageArray[i];// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图  共享元素
        [browseItemArray addObject:browseItem];
    }
    MSSCollectionViewCell *cell = (MSSCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:cell.imageView.tag - 100];
    //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];


}

@end

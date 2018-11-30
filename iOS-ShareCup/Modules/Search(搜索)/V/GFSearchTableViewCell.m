//
//  GFSearchTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/30.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFSearchTableViewCell.h"
#import "GFSearchCollectionViewCell.h"
#import "GFShowAllClassViewController.h"

@interface GFSearchTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation GFSearchTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTheAdArray) name:@"hotAdArray" object:nil];
    }
    return self;
}

- (void)setUpUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(120, 120);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 6;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 5);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, KScreenWidth, 140) collectionViewLayout:layout];
    [_collectionView registerClass:[GFSearchCollectionViewCell class] forCellWithReuseIdentifier:@"searchCell"];
    _collectionView.backgroundColor = [UIColor whiteColor]            ;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray)
    {
        return self.dataArray.count;
    }
    else
    {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchCell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[GFSearchCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    if (self.dataArray)
    {
        [cell setUIDataImage:self.imageArray[indexPath.item] AndName:self.dataArray[indexPath.item]];
    }
    
    return cell;
}
//点击collectionCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.dataArray[indexPath.item];
    self.callBack(str);
}

- (void) addTheAdArray
{
    [self.collectionView reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hotAdArray" object:nil];
}


@end

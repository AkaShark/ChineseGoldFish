//
//  GFHomeMiddleTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 11/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFHomeMiddleTableViewCell.h"
#import "GFHomeFunctionCollectionViewCell.h"

@interface GFHomeMiddleTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation GFHomeMiddleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(5, 25, 8, 25);
    layout.itemSize = CGSizeMake(140, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self.collectionView registerClass:[GFHomeFunctionCollectionViewCell class] forCellWithReuseIdentifier:@"middleCell"];
    
    [self addSubview:_collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.directionalLockEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
#pragma mark - collectionDelagate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.funcArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFHomeFunctionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"middleCell" forIndexPath:indexPath];
    
    [cell setUpData:self.funcArray[indexPath.row]];
    return cell;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.callBack(indexPath.item);
}


- (NSMutableArray *)funcArray
{
    if (!_funcArray) 
    {
        NSArray *array = @[@"history",@"classify",@"breed",@"photos"];
        _funcArray = (NSMutableArray *)array;
    }
    return _funcArray;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.bounds = CGRectMake(0, 0, self.bounds.size.width, 200);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  GFShowClassCollectionViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFShowDetailModel;
@interface GFShowClassCollectionViewCell : UICollectionViewCell
// 数据模型
@property (nonatomic,strong) GFShowDetailModel *model;

// 用于获取到cell的image 将这个变成了公开属性
@property (nonatomic,strong) UIImageView *classImage;

@end

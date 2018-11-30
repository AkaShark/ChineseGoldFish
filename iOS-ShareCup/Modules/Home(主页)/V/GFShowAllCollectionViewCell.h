//
//  GFShowAllCollectionViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFShowDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GFShowAllCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) GFShowDetailModel *model;

@property (nonatomic,strong) UIImageView *showImgV;

@end

NS_ASSUME_NONNULL_END

//
//  GFSearchTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/30.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^callBack)(NSString *str);

@interface GFSearchTableViewCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *imageArray;

@property (nonatomic,copy)callBack callBack;


@end

NS_ASSUME_NONNULL_END

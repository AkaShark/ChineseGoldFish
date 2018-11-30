//
//  GFHomeMiddleTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 11/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCallBack)(NSInteger tag);

@interface GFHomeMiddleTableViewCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *funcArray;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,copy) clickCallBack callBack;

@end

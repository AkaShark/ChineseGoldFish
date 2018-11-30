//
//  UICollectionView+IndexPath.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (IndexPath)

//设置indexPath 用于记录
- (void)setCurrentIndexPath:(NSIndexPath *)indexPath;

//获取上一个方法 将存储的indexPath拿来使用

- (NSIndexPath *)currentIndexPath;

@end

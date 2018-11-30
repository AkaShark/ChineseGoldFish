//
//  UICollectionView+IndexPath.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "UICollectionView+IndexPath.h"
#import <objc/runtime.h>


static NSString * const KIndexPathKey = @"KIndexPathKey";


@implementation UICollectionView (IndexPath)

- (void)setCurrentIndexPath:(NSIndexPath *)indexPath
{
//    通过此函数保留indexPath
    objc_setAssociatedObject(self, &KIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSIndexPath *)currentIndexPath
{
    NSIndexPath *indexPath = objc_getAssociatedObject(self, &KIndexPathKey);
    return indexPath;
}



@end

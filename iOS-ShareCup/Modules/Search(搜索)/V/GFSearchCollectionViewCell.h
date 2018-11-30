//
//  GFSearchCollectionViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/30.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFSearchCollectionViewCell : UICollectionViewCell


/**
 传入数据

 @param imageName 图片url
 @param name classNaame
 
 */
- (void)setUIDataImage:(NSString *)imageName AndName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

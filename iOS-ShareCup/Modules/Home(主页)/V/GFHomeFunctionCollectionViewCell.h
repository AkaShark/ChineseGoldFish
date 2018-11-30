//
//  GFHomeFunctionCollectionViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 11/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickImage)(void);

@interface GFHomeFunctionCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) clickImage callBack;


//// 传递数据
-(void)setUpData:(NSString *)imageName;

@end

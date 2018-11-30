//
//  GFShowDetaiTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/25.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFShowVarietyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GFShowDetaiTableViewCell : UITableViewCell
//数据model
@property (nonatomic,strong) GFShowVarietyModel *model;
// 返回cell hight
//- (float) returnTheHightOfCell;

@end

NS_ASSUME_NONNULL_END


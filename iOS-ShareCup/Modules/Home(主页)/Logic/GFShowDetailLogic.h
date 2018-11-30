//
//  GFShowDetailLogic.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/2.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFShowVarietyModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 variety 请求抽象类
 */
@interface GFShowDetailLogic : NSObject

// 请求类型
@property (nonatomic,copy) NSString *type;
// 类名
@property (nonatomic,copy) NSString *className;
////model
//@property (nonatomic,strong) GFShowVarietyModel *model;
//model数组
@property (nonatomic,strong) NSMutableArray *modelArray;
//请求数据
- (void)requestData;



@end

NS_ASSUME_NONNULL_END

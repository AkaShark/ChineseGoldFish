//
//  GFShowClassLogic.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ShowClassDelegate <NSObject>
@optional
// 完成加载数据
- (void)requestDataCompleted;
@end

/**
 抽离的逻辑层
 */
@interface GFShowClassLogic : NSObject
//代理
@property (nonatomic,weak) id<ShowClassDelegate> delegate;
// 数据数组
@property (nonatomic,strong) NSMutableArray *dataArray;
// 选择类型 （manyClass fourClass 详见服务端接口）
@property (nonatomic,copy) NSString *type;

// 请求数据
- (void)requestData;

//请求全部数据


@end

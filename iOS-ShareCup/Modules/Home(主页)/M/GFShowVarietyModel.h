//
//  GFShowVarietyModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/2.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFShowVarietyModel : NSObject
// 图片地址
@property (nonatomic,copy) NSString *imageURl;
// 描述
@property (nonatomic,copy) NSString *detailStr;
// 种类名
@property (nonatomic,copy) NSString *varietyName;


@end

NS_ASSUME_NONNULL_END

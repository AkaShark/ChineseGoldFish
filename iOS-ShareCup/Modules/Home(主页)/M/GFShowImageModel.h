//
//  GFShowImageModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/7.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFShowImageModel : NSObject
// 封面图片地址
@property (nonatomic,copy) NSString *contentUrl;
// 标题名字
@property (nonatomic,copy) NSString *contentTitle;
// 内容图片名字
@property (nonatomic,copy) NSString *images;

@end

NS_ASSUME_NONNULL_END

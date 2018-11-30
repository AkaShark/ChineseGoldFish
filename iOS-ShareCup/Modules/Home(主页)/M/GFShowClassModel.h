//
//  GFShowClassModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFShowClassModel : NSObject
// 图片Url
@property (nonatomic,copy) NSArray *image;
// 类名
@property (nonatomic,copy) NSArray *ClassName;
// 类的具体
@property (nonatomic,copy) NSArray *classDetail;

@end

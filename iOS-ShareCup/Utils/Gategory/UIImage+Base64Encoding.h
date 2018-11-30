//
//  UIImage+Base64Encoding.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/2.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Base64Encoding)
+(NSString *)imageBaseEncodeWithimageName:(NSString *)name;
+(NSString *)imageBaseEncodeWithimage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END

//
//  UIImage+Base64Encoding.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/2.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "UIImage+Base64Encoding.h"

@implementation UIImage (Base64Encoding)

+(NSString *)imageBaseEncodeWithimageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImgStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return encodedImgStr;
}

+(NSString *)imageBaseEncodeWithimage:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImgStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImgStr;
}

@end

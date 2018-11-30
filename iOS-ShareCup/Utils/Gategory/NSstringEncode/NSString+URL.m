//
//  NSString+URL.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/29.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

+(NSString *)encodeString:(NSString *)unencodedString
{
       NSString *encode = [unencodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encode;
}

+(NSString *)decodeString:(NSString *)encodeString
{
    
    NSString *decodeUrlString = [encodeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //url解码
    
    return decodeUrlString;
}

@end

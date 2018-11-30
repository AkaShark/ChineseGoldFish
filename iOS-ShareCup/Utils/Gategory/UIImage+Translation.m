//
//  UIImage+Translation.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/23.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "UIImage+Translation.h"
#import <objc/runtime.h>

@implementation UIImage (Translation)

static void SwizzleMethod(Class cls, SEL ori, SEL rep) {
    Method oriMethod = class_getInstanceMethod(cls, ori);
    Method repMethod = class_getInstanceMethod(cls, rep);
    
    BOOL flag = class_addMethod(cls, ori, method_getImplementation(repMethod), method_getTypeEncoding(repMethod));
    
    if (flag) {
        class_replaceMethod(cls, rep, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, repMethod);
    }
}

+(void)load
{
    
    SwizzleMethod(object_getClass([UIImage class]), @selector(imageNamed:), @selector(lsh_imageName:));
}


+ (UIImage *)lsh_imageName:(NSString *)imageName{
    //    检查当前系统的语言版本
    //    获取语言表示 (English)
    NSString *language = [[NSBundle mainBundle] preferredLocalizations][0];
    if ([language isEqualToString:@"en"])
    {
        NSString *imageOr = imageName;
        imageName = [imageName stringByAppendingString:@"_en"];
        if ([UIImage lsh_imageName:imageName])
        {
            return [UIImage lsh_imageName:imageName];
        }
        else{
            return [UIImage lsh_imageName:imageOr];
        }
    }
    
    //    调用原本的imageName方法
    return [UIImage lsh_imageName:imageName];
    
}

@end

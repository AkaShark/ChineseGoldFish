//
//  NSString+Translation.m
//  NSString_Translation
//
//  Created by kys-20 on 2018/11/11.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "NSString+Translation.h"
#import "NSString+Hash.h"
#import "POST&GET.h"
#import <objc/runtime.h>

static void *strKey = &strKey;

static NSString *appID = @"49fca85a0206ce95";
static NSString *appS = @"XVGuCPdFbrzSSUkqf4eFNOsEEKUNVTOT";

@implementation NSString (Translation)

+ (void)translation:(NSString *)str CallbackStr:(returnTranslationStr)callbackStr
{
    
//    获取语言表示
    NSString *language = [[NSBundle mainBundle] preferredLocalizations][0];
    if ([language isEqualToString:@"en"])
    {
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",appID,str,@"2",appS];
        sign = sign.md5String;
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSString *url = [NSString stringWithFormat:@"http://openapi.youdao.com/api?q=%@&from=%@&to=%@&appKey=%@&salt=%@&sign=%@",str,@"zh_CHS",language,appID,@"2",sign];
        [POST_GET GET:url parameters:nil succeed:^(id responseObject) {
            callbackStr(responseObject[@"translation"][0]);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    else{
        callbackStr(str);
    }
    
}

- (void)setCallBackStr:(returnTranslationStr)callBackStr
{
    objc_setAssociatedObject(self, &strKey, callBackStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (returnTranslationStr)callBackStr
{
    return objc_getAssociatedObject(self, &strKey);
}




@end

//
//  NSString+Translation.h
//  NSString_Translation
//
//  Created by kys-20 on 2018/11/11.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnTranslationStr)(NSString *str);

@interface NSString (Translation)

@property (nonatomic,copy) returnTranslationStr callBackStr;

+ (void)translation:(NSString *)str CallbackStr:(returnTranslationStr)callbackStr;

@end

NS_ASSUME_NONNULL_END

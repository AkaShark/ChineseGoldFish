//
//  NSObject+LSHUIExtension.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/29.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LSHUIExtension)

//创建UILabel
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                      color:(UIColor *)color
                       font:(UIFont *)font
              textAlignment:(NSTextAlignment)textAlignment;

//创建UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                              color:(UIColor *)color
                               font:(UIFont *)font
                    secureTextEntry:(BOOL)secureTextEntry
                           delegate:(id)delegate;

//创建UITextView
+ (UITextView *)textViewWithFrame:(CGRect)frame
                             text:(NSString *)text
                            color:(UIColor *)color
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment;

//创建UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        color:(UIColor *)color
                         font:(UIFont *)font
              backgroundImage:(UIImage *)backgroundImage
                       target:(id)target
                       action:(SEL)action;

//创建图片
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage*)image;

//创建背景图片
+ (UIImage *)imageWithColor:(UIColor*)color;

@end


NS_ASSUME_NONNULL_END

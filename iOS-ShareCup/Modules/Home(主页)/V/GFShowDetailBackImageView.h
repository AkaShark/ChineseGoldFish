//
//  GFShowDetailBackImageView.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/25.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFShowDetailBackImageView : UIView

- (void)whenScrollGetOffset:(CGPoint )offest;

- (void)setUpUI:(NSString *)image AndDetail:(NSString *)detail ClassName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

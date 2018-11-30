//
//  CardView.m
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "CardView.h"
#import "UIImage+ImageEffects.h"


@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor clearColor];
    
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_imageView];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(7.0, 7.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
    
    
    _selectedView = [[UIView alloc]init];
    _selectedView.frame = _imageView.frame;
    
    _selectedView.backgroundColor = [UIColor clearColor];
    _selectedView.alpha = 1.0;
//    [_imageView addSubview:_selectedView];
    
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor whiteColor];
    _label.frame = CGRectMake(0, self.frame.size.height * 0.85, self.frame.size.width , self.frame.size.height * 0.15);
    _label.font = [UIFont fontWithName:@"Futura-Medium" size:18];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.numberOfLines = 0;
    [_imageView addSubview:_label];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

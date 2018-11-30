//
//  AssignInfoSingleCellView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "AssignInfoSingleCellView.h"
#import "UIView+BearSet.h"
@implementation AssignInfoSingleCellView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:18];
        _numLabel.textColor = [UIColor colorWithHexString:@"0d9fff"];
        [self addSubview:_numLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"Verdana" size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"0d9fff"];
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_numLabel sizeToFit];
    [_titleLabel sizeToFit];
    
    [self setWidth:MAX(_numLabel.width, _titleLabel.width)];
    [UIView BearAutoLayViewArray:(NSMutableArray *)self.subviews layoutAxis:kLAYOUT_AXIS_Y center:YES gapDistance:2];
}

@end

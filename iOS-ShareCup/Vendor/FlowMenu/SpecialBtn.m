
//
//  SpecialBtn.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "SpecialBtn.h"

@interface SpecialBtn ()

@end

@implementation SpecialBtn

@synthesize collisionBoundsType;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _keyFrameAniamtion = [CAKeyframeAnimation animation];
    }
    return self;
}

@end

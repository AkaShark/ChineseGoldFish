//
//  GFLayer.m
//  iOS-ShareCup
//
//  Created by kys-20 on 12/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFLayer.h"

@implementation GFLayer
- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}


- (void)createLayerFrame:(CGRect) frame
         BackGroundColor:(UIColor *)color
            shadowOpacity:(CGFloat )opacity
            shadowOffect:(CGSize )offect
              cornRadius:(CGFloat )radius
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    layer.shadowOffset = offect;
    layer.shadowOpacity = opacity;
    layer.cornerRadius= radius;
}
@end

//
//  HUDTA.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/28.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "HUDTA.h"

@implementation HUDTA
- (instancetype) init
{
    if (self = [super init])
    {
        
    }
    return self;
}


- (void)showHudWithStr:(NSString *)str AndOption: (TAOverlayOptions )option
{
//    设置
    TAOverlayOptions options = TAOverlayOptionNone;
    options = options | TAOverlayOptionOverlaySizeRoundedRect;
    options = options | TAOverlayOptionAllowUserInteraction;
    options = options | TAOverlayOptionAutoHide;
    options = options | option;
    
    [TAOverlay showOverlayWithLabel:str Options:options];
    
}

- (void)showScreenHudWithStr:(NSString *)str AndOption: (TAOverlayOptions )option
{
    //    设置
    TAOverlayOptions options = TAOverlayOptionNone;
    options = options | TAOverlayOptionOverlaySizeRoundedRect;
    options = options | TAOverlayOptionAllowUserInteraction;
    options = options | option;
    
    [TAOverlay showOverlayWithLabel:str Options:options];
    
}

- (void)hiddenHud
{
    [TAOverlay hideOverlay];
}


@end

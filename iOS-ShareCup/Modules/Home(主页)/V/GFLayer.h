//
//  GFLayer.h
//  iOS-ShareCup
//
//  Created by kys-20 on 12/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface GFLayer : CALayer

/**
 <#Description#>

 @param frame <#frame description#>
 @param color <#color description#>
 @param opacity <#opacity description#>
 @param offect <#offect description#>
 @param radius <#radius description#>
 */
- (void)createLayerFrame:(CGRect) frame
         BackGroundColor:(UIColor *)color
            shadowOpacity:(CGFloat )opacity
            shadowOffect:(CGSize )offect
              cornRadius:(CGFloat )radius;
@end

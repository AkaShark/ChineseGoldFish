//
//  HUDTA.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/28.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAOverlay.h"
NS_ASSUME_NONNULL_BEGIN


/**
 封装HUD
 */
@interface HUDTA : NSObject

- (void)showHudWithStr:(NSString *)str AndOption: (TAOverlayOptions )option;
- (void)showScreenHudWithStr:(NSString *)str AndOption: (TAOverlayOptions )option;
- (void)hiddenHud;
@end

NS_ASSUME_NONNULL_END

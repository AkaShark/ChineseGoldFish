//
//  GFNetState.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface GFNetState : NSObject

- (void)netOfState:(void(^)(int type))stateType;


@end

NS_ASSUME_NONNULL_END

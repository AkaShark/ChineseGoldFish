//
//  UserManager.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/27.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject


/**
 创建单例

 @return 返回对象
 */
+ (instancetype)defaultManager;

/**
 <#Description#>

 @param dict <#dict description#>
 */
- (void)initWithDict:(NSDictionary *)dict;

/**
 <#Description#>

 @return <#return value description#>
 */
- (NSDictionary *)getUserDict;
/**
// <#Description#>
//
// @param dict <#dict description#>
// @return <#return value description#>
// */
//+ (instancetype)userManagerWithDict:(NSDictionary *)dict;
//
//
///**
// <#Description#>
//
// @param dict <#dict description#>
// @return <#return value description#>
// */
//- (instancetype)initWithDict:(NSDictionary *)dict;
//

@end

NS_ASSUME_NONNULL_END

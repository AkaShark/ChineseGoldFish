//
//  NSString+URL.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/29.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URL)


/**
 urlencode

 @param unencodedString <#unencodedString description#>
 @return <#return value description#>
 */
+ (NSString *)encodeString:(NSString *)unencodedString;



/**
 urldecode

 @param encodeString <#encodeString description#>
 @return <#return value description#>
 */
+(NSString *)decodeString:(NSString *)encodeString;


@end

NS_ASSUME_NONNULL_END

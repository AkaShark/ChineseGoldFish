//
//  UpLoadPhoto.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/31.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"QiniuSDK.h"
#import"AFNetworking.h"
#import<CommonCrypto/CommonCrypto.h>
#import"QN_GTM_Base64.h"
//#import"QBEtag.h"
#import"QNConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QNUpSuccess)(NSString *result);
typedef void(^QNUpFail)(NSString *error);


@interface UpLoadPhoto : NSObject

//单例
+(instancetype)detaultManager;

/**
 图片上传

 @param filePath 文件路径
 @param name 用户名 （内部自动拼接了）
 @param success 成功回调
 @param failure 失败回调
 */
- (void)uploadImageToFilePath:(NSString *)filePath Name:(NSString *)name success:(QNUpSuccess)success failure:(QNUpFail)failure;



/**
 直接上传data

 @param data <#data description#>
 @param name <#name description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)uploadImageToQNData:(NSData *)data Name :(NSString *)name success:(QNUpSuccess)success failure:(QNUpFail)failure;
@end

NS_ASSUME_NONNULL_END

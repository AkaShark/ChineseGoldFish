//
//  POST&GET.h
//  murakumo
//
//  Created by kys-24 on 2017/2/27.
//  Copyright © 2017年 kys-24. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POST_GET : NSObject

+ (NSString *)TheTimeStamp;
/**
 封装get请求

 @param URLString URL
 @param parameters 参数字典
 @param succeed 成功后返回的JSON数据
 @param failure 失败后返回的JSON数据
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;

/**
 封装post请求

 @param URLString URL
 @param parameters 参数字典
 @param success 成功后返回的JSON
 @param failure 失败后返回的JSON
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 进一步封装的post请求

 @param URLString URL
 @param parameters 参数
 @param success 成功后返回的JSON
 @param failure 失败后返回的JSON
 @param is 是否加入session
 @param Parser 使用http解析还是json解析
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure andIsAddSession:(BOOL)is orSetDifferentParser:(BOOL)Parser;


/**
 百度图像识别方法
 请求失败访问接口 获取新的token 本地暂时存储
 @param URLString url
 @param parameters 参数
 @param success 成功
 @param failure 失败
 */
+ (void)POSTBaiDu:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;



@end

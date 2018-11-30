//
//  POST&GET.m
//  murakumo
//
//  Created by kys-24 on 2017/2/27.
//  Copyright © 2017年 kys-24. All rights reserved.
//

//封装的时候考虑一个问题 类方法用self 调方法去访问变量

#import "POST&GET.h"
#import "AFNetworking.h"
#ifdef DEBUG
#define ACLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ACLog(...)
#endif

@interface POST_GET()

@end

@implementation POST_GET

+ (void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure
{
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"image/png",@"",nil];
    
    //返回的为非json
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *cookie = [defaults objectForKey:@"cookie"];
//    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    //发送网络请求(请求方式为GET)
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //会话 可以在这里上传下载 *downloadProgress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}



+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //返回非json
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //image 加解析 image/
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    
    //为主界面的请求加cookie加的是验证码的
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//       NSString *cookie = [defaults objectForKey:@"Cookie"];
//    NSLog(@"Cookie = %@",cookie);
//     [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //会话 可以在这里上传下载 *downloadProgress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//百度
+ (void)POSTBaiDu:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                //会话 可以在这里上传下载 *downloadProgress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
}


//解析器
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure andIsAddSession:(BOOL)is orSetDifferentParser:(BOOL)Parser{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (Parser) {
        //2进制
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else{
        //json数据
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //会话 可以在这里上传下载 *downloadProgress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse* response = (NSHTTPURLResponse *)task.response;
        NSString* dataCookie = [NSString stringWithFormat:@"%@",[[response.allHeaderFields[@"Set-Cookie"]componentsSeparatedByString:@";"]objectAtIndex:0]];
        //获取未处理的cookie
//        NSString *dataCookie = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
        NSLog(@"cookie2 －> %@", dataCookie);
        //存储cookie
        [[NSUserDefaults standardUserDefaults] setObject:dataCookie forKey:@"cookie"];
        ACLog(@"%@",dataCookie);
        if (is) {
            [manager.requestSerializer setValue:dataCookie forHTTPHeaderField:@"Cookie"];//设置到headerField
        }else
        {
            
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (NSString *)TheTimeStamp{
    //设置一个NSDateFormatter的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}



@end

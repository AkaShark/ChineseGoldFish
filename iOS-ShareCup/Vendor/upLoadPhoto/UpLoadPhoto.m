//
//  UpLoadPhoto.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/31.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "UpLoadPhoto.h"

static NSString *accessKey = @"0vItX7lYUYJZUgEG2H7GtNUXw6iVz5q1Zb32lSoQ";
static NSString *secretKey = @"ovCz6skGgDXr7l2SQfdAbrhIQHBhjF-CTUhh5iKh";

@implementation UpLoadPhoto

//单例
static UpLoadPhoto *instance;

+(instancetype)detaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}


- (void)uploadImageToQNData:(NSData *)data Name :(NSString *)name success:(QNUpSuccess)success failure:(QNUpFail)failure
{
    NSString *token = [[UpLoadPhoto detaultManager] makeToken:accessKey secretKey:secretKey];
    
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone1];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
//    NSString *fileName = [NSString stringWithFormat:@"%@HeadIcon.png",name];
    
    
    [upManager putData:data key:name token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        NSString *path = [[NSString alloc] init];
        if (info.isOK)
        {
            path = [NSString stringWithFormat:@"%@%@",kQNinterface,resp[@"key"]];
        }
        if (success)
        {
            success(path);
            
        }
    } option:uploadOption];
}

//上传图片
- (void)uploadImageToFilePath:(NSString *)filePath Name:(NSString *)name success:(QNUpSuccess)success failure:(QNUpFail)failure
{
    NSString *token = [[UpLoadPhoto detaultManager] makeToken:accessKey secretKey:secretKey];
   
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone1];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    NSString *fileName = [NSString stringWithFormat:@"%@HeadIcon.png",name];
    
    
    [upManager putFile:filePath key:fileName token: token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        NSString *path = [[NSString alloc] init];
        if (info.isOK)
        {
           path = [NSString stringWithFormat:@"%@%@",kQNinterface,resp[@"key"]];
        }
        if (success)
        {
            success(path);
        }
    }option:uploadOption];
    

}

// 生成Token
- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey{
    const char *secretKeyStr = [secretKey UTF8String];
    NSString *policy = [self marshal];
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedPolicy = [QN_GTM_Base64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    NSString *encodedDigest = [QN_GTM_Base64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    return token;//得到了token
}

- (NSString *)marshal{
    NSInteger _expire = 0;
    time_t deadline;
    time(&deadline);//返回当前系统时间
    //@property (nonatomic , assign) int expires; 怎么定义随你...
    deadline += (_expire > 0) ? _expire : 86400; // +3600秒,即默认token保存1小时.
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"sharkerhub" forKey:@"scope"];//根据
    [dic setObject:deadlineNumber forKey:@"deadline"];
    NSString *json = [self convertToJsonData:dic ];
    return json;
}
- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


@end

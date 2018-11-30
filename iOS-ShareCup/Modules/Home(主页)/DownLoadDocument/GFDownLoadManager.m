//
//  GFDownLoadManager.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/19.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFDownLoadManager.h"
#import "GFDownLoadSessionManager.h"
#import "NSString+Hash.h"


@interface GFDownLoadManager()

// 存放任务session以及其对应的url的字典
@property (nonatomic,strong) NSMutableDictionary *sessionDictionary;
@property (nonatomic,copy) NSString *speed;
@end

@implementation GFDownLoadManager

- (void)nowStateOfNet:(void(^)(NSString *state))State
{
    GFDownLoadSessionManager *downloadSessionManager = [[GFDownLoadSessionManager alloc] init];
    [downloadSessionManager nowStateOfNet:^(NSString * _Nonnull state) {
        State(state);
    }];
}


// 下载方法
- (void)downloadFromURL:(NSString *)urlString progress:(void(^)(CGFloat downloadProgress,NSString *speed))downloadProgressBlock complement:(void(^)(NSString *filePath,NSError *error))completeBlock
{
// 是否请求的url还有在字典中
    if (![self.sessionDictionary.allKeys containsObject:urlString.md5String])
    {
//        如果没有的话 将 session存储到字典中 K 为url的md5
        GFDownLoadSessionManager *downloadSessionManager = [[GFDownLoadSessionManager alloc] init];
        self.sessionDictionary[urlString.md5String] = downloadSessionManager;
        
//        调用下载方法
        [downloadSessionManager downloadFromURL:urlString progress:^(CGFloat downloadProgress,NSString *speed) {
            dispatch_async(dispatch_get_main_queue(), ^{
//               返回主线程将rprogress回调 更新UI
                !downloadProgressBlock?:downloadProgressBlock(downloadProgress,speed);
            });
        } complement:^(NSString * _Nonnull filePath, NSError * _Nonnull error) {
//           不错误
            if(!error)
            {
//              移除这个session
                [self.sessionDictionary removeObjectForKey:urlString.md5String];
                dispatch_async(dispatch_get_main_queue(), ^{
                    !completeBlock?:completeBlock(filePath,nil);
                });
            }
        }];
        [downloadSessionManager resume];
        
    }
}

// 继续任务
- (void)resumeTaskWithURL:(NSString *)urlString
{
//    ..
    GFDownLoadSessionManager *downloadSessionManager = self.sessionDictionary[urlString.md5String];
    if (!downloadSessionManager)
    {
        
        [NSException raise:@"There are no this task" format:@"Can not find the given url task"];
        
        return;
    }

    [downloadSessionManager resume];
    
}
// 继续全部任务
- (void)resumeAllTasks
{
    [self.sessionDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [obj resume];
    }];
}

// 暂停任务
- (void)supendTaskWithURL:(NSString *)urlString
{
    GFDownLoadSessionManager *downloadSessionManager = self.sessionDictionary[urlString.md5String];
    [downloadSessionManager suspend];
}

- (void)suspendAllTasks
{
    [self.sessionDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [obj suspend];
    }];
}

- (void)cancelTaskWithURL:(NSString *)urlString
{
    GFDownLoadSessionManager *downloadSessionManager = self.sessionDictionary[urlString.md5String];
    [downloadSessionManager cancel];
}

- (void)cancelAllTasks{
    [self.sessionDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
}

- (NSMutableDictionary *)sessionDictionary
{
    if (!_sessionDictionary)
    {
        _sessionDictionary = [NSMutableDictionary dictionary];
    }
    return _sessionDictionary;
}

//单例的实现
static GFDownLoadManager *instance;

+ (instancetype)detaultManager
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


@end

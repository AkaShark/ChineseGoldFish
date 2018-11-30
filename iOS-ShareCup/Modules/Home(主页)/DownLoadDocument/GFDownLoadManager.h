//
//  GFDownLoadManager.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/19.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFDownLoadManager : NSObject

//单例
+(instancetype)detaultManager;

// 当前网络状态
- (void)nowStateOfNet:(void(^)(NSString *state))State;

//下载方法
- (void)downloadFromURL:(NSString *)urlString progress:(void(^)(CGFloat downloadProgress,NSString *speed))downloadProgressBlock complement:(void(^)(NSString *filePath,NSError *error))completeBlock;

//暂停某个url的下载任务
- (void)supendTaskWithURL:(NSString *)urlString;

//暂停全部的任务
- (void)suspendAllTasks;

//继续某个任务
- (void)resumeTaskWithURL:(NSString *)urlString;

//继续所有下载任务
- (void)resumeAllTasks;

//取消某个url的下载任务，取消以后必须程重新设置任务
- (void)cancelTaskWithURL:(NSString *)urlString;

//取消所有的下载任务，取消以后必须重新设置任务

- (void)cancelAllTasks;


@end

NS_ASSUME_NONNULL_END

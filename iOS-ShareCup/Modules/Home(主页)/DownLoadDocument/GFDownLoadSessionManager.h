//
//  GFDownLoadSessionManager.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/19.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFDownLoadSessionManager : NSObject


// 当前网络状态
- (void)nowStateOfNet:(void(^)(NSString *state))State;

/**
 继续任务
 */
- (void)resume;


/**
 停止下载任务
 */
- (void)suspend;


/**
 取消任务
 */
- (void)cancel;


/**
 下载方法

 @param urlString uRL
 @param downloadProgressBlock 回调
 @param completeBlock 回调
 */
- (void)downloadFromURL:(NSString *)urlString progress:(void(^)(CGFloat downloadProgress, NSString * speed))downloadProgressBlock complement:(void (^) (NSString *filePath,NSError *error))completeBlock;


@end

NS_ASSUME_NONNULL_END

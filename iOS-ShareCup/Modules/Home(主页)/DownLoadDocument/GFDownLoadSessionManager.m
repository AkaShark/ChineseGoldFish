//
//  GFDownLoadSessionManager.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/19.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFDownLoadSessionManager.h"
#import "NSString+Hash.h"
#import "GFNetState.h"
/**文件存放路径*/
#define GFFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self.fileName]
/**文件总长度字典存放的路径*/
#define GFTotalDataLenthDic [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"totalDataLengththDictionaryPath.data"]
/**已经下载的文件长度 字节大小*/
#define GFAlreadDownloadLength [[[NSFileManager defaultManager]attributesOfItemAtPath:GFFilePath error:nil][NSFileSize] integerValue]


@interface GFDownLoadSessionManager()<NSURLSessionDataDelegate>


/**
 根据文件名存储文件的总大小
 */
@property(nonatomic,strong)NSMutableDictionary *totalDataLengthDictionary;


/**
 下载进度
 */
@property (nonatomic,assign)CGFloat downloadProgress;

/**
 网址
 */
@property (nonatomic,copy) NSString *urlString;

/**
 存储文件名
 */
@property (nonatomic,copy) NSString *fileName;


/**
 任务
 */
@property (nonatomic,strong)NSURLSessionDataTask *dataTask;


/**
 会话
 */
@property (nonatomic,strong)NSURLSession *session;

/**
 下载流
 */
@property (nonatomic,strong) NSOutputStream *stream;

/**
 错误信息
 */
@property (nonatomic,strong) NSError *downloadError;


/**
 下载过程中的回调block
 */
@property (nonatomic,copy)void (^downloadProgressBlock)(CGFloat progress,NSString *speed);


/**
 是否停了
 */
@property (nonatomic,assign) BOOL isSuspend;

/**
 是否下载
 */
@property (nonatomic,assign)BOOL isDownloading;

/**
 下载完成回调
 */
@property (nonatomic,copy) void (^completeBlock)(NSString *describe,NSError *error);

/**
 下载速度
 */
@property (nonatomic,copy) NSString *speed;
//
//需要将dispatch_source_t timer设置为成员变量，不然会立即释放
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic,assign) long length;

@end

@implementation GFDownLoadSessionManager


- (NSString *)urlString
{
    if (!_urlString)
    {
        _urlString = @"http://47.104.211.62/GlodFish/GlodFishDoucument/literature/%E4%B8%AD%E5%9B%BD%E9%87%91%E9%B1%BC%E5%93%81%E7%A7%8D%E9%80%89%E8%82%B2%E7%9A%84%E7%A0%94%E7%A9%B6%E8%BF%9B%E5%B1%95.pdf";
        }
    return _urlString;
}

- (NSOutputStream *)stream
{
    if (!_stream)
    {
//        ..
        _stream = [[NSOutputStream alloc]initToFileAtPath:GFFilePath append:YES];
    }
    return _stream;
}
- (NSURLSessionDataTask *)dataTask
{
    if (!_dataTask)
    {
        NSError *error = nil;
        NSInteger alreadDownloadLength = GFAlreadDownloadLength;
        //下载完成
        if ([self.totalDataLengthDictionary[self.fileName]integerValue] && [self.totalDataLengthDictionary[self.fileName]integerValue] == GFAlreadDownloadLength)
        {
        //   开始回调
            !self.completeBlock?:self.completeBlock(GFFilePath,nil);
            return nil;
        }
//        如果已经存在的文件比目标大说明下载文件错误执行删除文件重新下载
        else if ([self.totalDataLengthDictionary[self.fileName] integerValue] < GFAlreadDownloadLength)
        {
            [[NSFileManager defaultManager]removeItemAtPath:GFFilePath error:&error];
            if (!error)
            {
                alreadDownloadLength = 0;
            }
            else
            {
                NSLog(@"创建任务失败重开吧");
                return nil;
            }
        }
        
        //            正常下载 已经下载小于总文件的大小
        //            创建mutableRequest对象
        NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        
        //            设置请求头的range
        [mutableRequest setValue:[NSString stringWithFormat:@"bytes=%ld-",alreadDownloadLength] forHTTPHeaderField:@"Range"];
        _dataTask = [self.session dataTaskWithRequest:mutableRequest];
        
    }
    return _dataTask;
}

- (NSMutableDictionary *)totalDataLengthDictionary
{
    if (!_totalDataLengthDictionary)
    {
        _totalDataLengthDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:GFTotalDataLenthDic];
        if (!_totalDataLengthDictionary)
        {
            _totalDataLengthDictionary = [NSMutableDictionary dictionary];
        }
    }
    return _totalDataLengthDictionary;
}

- (NSURLSession *)session
{
//    .. 开启子线程搞的
    if (!_session)
    {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
    }
    return _session;
}

- (void)resume
{
    if (!self.isDownloading)
    {
        [self.dataTask resume];
        self.isDownloading = YES;
        self.isSuspend = NO;
    }
}

- (void)suspend{
    if (!self.isSuspend)
    {
        [self.dataTask suspend];
        self.isSuspend = YES;
        self.isDownloading = NO;
    }
}

- (void)cancel
{
    [self.session invalidateAndCancel];
    self.session = nil;
    self.dataTask = nil;
    !self.completeBlock?:self.completeBlock(GFFilePath,nil);
}

- (void)nowStateOfNet:(void(^)(NSString *state))State
{
    GFNetState *netState = [[GFNetState alloc] init];
    [netState netOfState:^(int type) {
        if (type == 0)
        {
            State(@"没有网络");
        }
        if (type == 1)
        {
            State(@"使用移动数据");
        }
        else
        {
            State(@"使用无线网络");
        }
    }];
}


#pragma mark- delegate
//服务器响应以后的代理方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
//    NSLog(@"%@",[NSThread currentThread]);
//
    _length = GFAlreadDownloadLength;

////    设置定时器
//   _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(getNowDownLoadSpeed) userInfo:nil repeats:YES];

//    __weak typeof(self) WeakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.timer = [NSTimer timerWithTimeInterval:10 block:^(NSTimer * _Nonnull timer) {
//            //        没一秒获取已经下载的量减去前一秒
//            self.speed = [NSString stringWithFormat:@"%ldk/s",GFAlreadDownloadLength -self.length];
//            NSLog(@"%@",self.speed);
//            self.length = GFAlreadDownloadLength;
//        } repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//        [[NSRunLoop currentRunLoop] run];
//    });
    
    //定时器开始执行的延时时间
    NSTimeInterval delayTime = 0.0f;
    //定时器间隔时间
    NSTimeInterval timeInterval = 1.0f;
    //创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //使用之前创建的队列来创建计时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置延时执行时间，delayTime为要延时的秒数
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    //设置计时器
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        //执行事件
        self.speed = [NSString stringWithFormat:@"%ldk/s",(GFAlreadDownloadLength -self.length)/1024];
//        NSLog(@"speed ------ %@",self.speed);
//        NSLog(@"%ld---%ld",self.length,GFAlreadDownloadLength);
        self.length = GFAlreadDownloadLength;
    });
    // 启动计时器
    dispatch_resume(_timer);
    
  
    
    
    
//    接受到服务器的响应
//    获取文件的全部长度
//    从头部取出的长度加上已经下载的长度
    self.totalDataLengthDictionary[self.fileName] = @([response.allHeaderFields[@"Content-Length"]integerValue] + GFAlreadDownloadLength);
//    ..
    [self.totalDataLengthDictionary writeToFile:GFTotalDataLenthDic atomically:YES];
    
//    打开输出流
    [self.stream open];
//    调用blcok设置允许进一步访问
    completionHandler(NSURLSessionResponseAllow);
}


//收到数据后调用的代理方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    //    把服务端数据传回的数据用stream写入沙盒
    [self.stream write:data.bytes maxLength:data.length];
    self.downloadProgress = 1.0 * GFAlreadDownloadLength / [self.totalDataLengthDictionary[self.fileName] integerValue];
}

//任务完成后的回调
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
//    取消定时器
    dispatch_source_cancel(_timer);
//    错误
    if(error)
    {
//        设置错误
        self.downloadError = error;
        return;
    }
//    如果正常的话
//    关闭流
    [self.stream close];
    
//    清空task ??? 队列中还有任务的话呢？ 只是针对这个一个session的
    [self.session invalidateAndCancel];
    self.session = nil;
    self.dataTask = nil;
    
//    清空总长度的字典
    [self.totalDataLengthDictionary removeObjectForKey:self.fileName];
//    写入文件
    [self.totalDataLengthDictionary writeToFile:GFTotalDataLenthDic atomically:YES];
//    完成回调返回文件地址
    !self.completeBlock?:self.completeBlock(GFFilePath,nil);
}
//学习封装性的方法 将block作为参数来进行回调 同时设置了全局的block来接受参数

//调用下载方法
- (void)downloadFromURL:(NSString *)urlString progress:(void(^)(CGFloat downloadProgress, NSString * speed))downloadProgressBlock complement:(void (^) (NSString *filePath,NSError *error))completeBlock
{
//    [[NSRunLoop currentRunLoop] run];
    self.urlString = urlString;
    self.fileName = [NSString stringWithFormat:@"%@.pdf",urlString.md5String];
    self.downloadProgressBlock = downloadProgressBlock;
    self.completeBlock = completeBlock;
}

//设置进度
- (void)setDownloadProgress:(CGFloat)downloadProgress
{
    _downloadProgress = downloadProgress;
//    学习设置block为参数的方法
    !self.downloadProgressBlock?:self.downloadProgressBlock(downloadProgress,_speed);
}

// 设置下载错误
- (void)setDownloadError:(NSError *)downloadError
{
    _downloadError = downloadError;
    !self.completeBlock?:self.completeBlock(nil,downloadError);
}



@end

//
//  GFDownloadDocumentTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/21.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFDownloadDocumentTableViewCell : UITableViewCell

@property (nonatomic,copy) void(^downloadTheDoucument)(void);

- (void)setDataisLoadingStr:(NSString *)isloading Progress:(CGFloat)progress Name:(NSString *)name Speed:(NSString *)speed;

- (void)isDowningTheDoucument:(NSString *)isDowning Speed:(NSString *)speed Progress:(CGFloat)progress;

- (void)finishDownLoadDoucment:(NSString *)isDowning Name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END


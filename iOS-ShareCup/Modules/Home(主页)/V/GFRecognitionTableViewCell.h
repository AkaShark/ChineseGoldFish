//
//  GFRecognitionTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFRecognitionTableViewCell : UITableViewCell

@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,strong) UILabel *sorcelbl;

/**
 赋值方法

 @param text 名称
 @param detail 小数
 @param progress 进度条
 */
- (void)passThedataTextLabel:(NSString *)text DetailStr: (NSString *)detail Progress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END

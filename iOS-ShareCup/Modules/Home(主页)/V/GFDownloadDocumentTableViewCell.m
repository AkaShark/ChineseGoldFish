//
//  GFDownloadDocumentTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/21.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFDownloadDocumentTableViewCell.h"

@interface GFDownloadDocumentTableViewCell()
{
    BOOL isFirst;
}
@property (nonatomic,strong) YYAnimatedImageView *downImgView;

@property (nonatomic,strong) UILabel *isLoadingLbl;

@property (nonatomic,strong) UILabel *nameLabl;

@property (nonatomic,strong) UILabel *speedLbl;

@property (nonatomic,strong) UIProgressView *progressView;

//@property (nonatomic,assign) CGFloat progress;

@property (nonatomic,strong) UIButton *downLoadBtn;

@end

@implementation GFDownloadDocumentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        isFirst = YES;
    }
    return self;
}

- (void)setUpUI
{
//    UIImage *image = [UIImage imageNamed:@"downLoadImage"];
    
    _downImgView = [[YYAnimatedImageView alloc] init];
    [self.contentView addSubview:_downImgView];

    [_downImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@23);
        make.height.equalTo(@41);
        make.width.equalTo(@41);
    }];

    _isLoadingLbl = [[UILabel alloc] init];
    _isLoadingLbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    _isLoadingLbl.textColor = [UIColor blackColor];
    [self.contentView addSubview:_isLoadingLbl];

    [_isLoadingLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downImgView.mas_right).offset(8);
        make.top.equalTo(self.downImgView.mas_top).offset(-8);
    }];

    _progressView = [[UIProgressView alloc] init];
    _progressView.trackTintColor = UIColor.lightGrayColor;
    [self.contentView addSubview:_progressView];

    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.isLoadingLbl.mas_left);
        make.top.equalTo(self.isLoadingLbl.mas_bottom).offset(5);
        make.width.equalTo(@200);
    }];

    _nameLabl = [[UILabel alloc] init];
    _nameLabl.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
    _nameLabl.textColor = [UIColor lightGrayColor];
    _nameLabl.numberOfLines = 0;
    [self.contentView addSubview:_nameLabl];

    [_nameLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.isLoadingLbl.mas_left);
        make.top.equalTo(self.progressView.mas_bottom).offset(10);
        make.width.equalTo(@200);
        make.bottom.equalTo(@(-10));
    }];

    _speedLbl = [[UILabel alloc] init];
    _speedLbl.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
    _speedLbl.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_speedLbl];
    
    [_speedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.isLoadingLbl.mas_centerY);
        make.left.equalTo(self.isLoadingLbl.mas_right).offset(5);
    }];
    
    _downLoadBtn = [[UIButton alloc] init];
    [NSString translation:@"下载" CallbackStr:^(NSString * _Nonnull str) {
        [_downLoadBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    _downLoadBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    [_downLoadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _downLoadBtn.layer.cornerRadius = 4;
    _downLoadBtn.layer.masksToBounds = YES;
    [_downLoadBtn setBackgroundColor:CNavBgColor];
//    RAC点击事件
    [[_downLoadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.downloadTheDoucument?:self.downloadTheDoucument();
    }];
    
    [self.contentView addSubview:_downLoadBtn];
    
    [_downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self).offset(-15);
    }];
    
}

- (void)setDataisLoadingStr:(NSString *)isloading Progress:(CGFloat)progress Name:(NSString *)name Speed:(NSString *)speed
{
    YYImage *image = [YYImage imageNamed:@"downLoadGif.gif"];
    _downImgView.image = image;
    _isLoadingLbl.text = isloading;
    _progressView.progress = progress;
    _nameLabl.text = name;
    _speedLbl.text = speed;
    
}

- (void)isDowningTheDoucument:(NSString *)isDowning Speed:(NSString *)speed Progress:(CGFloat)progress
{
    if (isFirst)
    {
        [self startImage];
    }
    _progressView.progress = progress;
    _isLoadingLbl.text = isDowning;
    _speedLbl.text = speed;
    _downLoadBtn.hidden = YES;
}

- (void)finishDownLoadDoucment:(NSString *)isDowning Name:(NSString *)name
{
    
    UIImage *image = [UIImage imageNamed:@"downLoadImage"];
    _progressView.hidden = YES;
    _downLoadBtn.hidden = YES;
//    [NSString translation:isDowning CallbackStr:^(NSString * _Nonnull str) {
//        _isLoadingLbl.text = str;
//    }];
    _isLoadingLbl.text = isDowning;
//    [NSString translation:name CallbackStr:^(NSString * _Nonnull str) {
//        _nameLabl.text = str;
//    }];
    _nameLabl.text = name;
    _speedLbl.text = @"";
    _downImgView.image = image;
    [_downImgView stopAnimating];

}

- (void)startImage
{
    isFirst = NO;
    _downImgView.image = [YYImage imageNamed:@"downLoadGif.gif"];
}
@end

//
//  GFRecognitionTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFRecognitionTableViewCell.h"


@implementation GFRecognitionTableViewCell
{
 
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self UI_config];
    }
    return self;
}

- (void)UI_config
{
    _titleLbl  = [[UILabel alloc] init];
    _titleLbl.textColor = [UIColor whiteColor];
    _titleLbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self.contentView addSubview:_titleLbl];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
    }];
    
    _sorcelbl = [[UILabel alloc] init];
    _sorcelbl.textColor = [UIColor whiteColor];
    _sorcelbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.contentView addSubview:_sorcelbl];
    [_sorcelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.equalTo(self->_titleLbl);
    }];
    
    _progressView = [[UIProgressView alloc] init];
    _progressView.trackTintColor = UIColor.clearColor;
    _progressView.progressTintColor = [UIColor whiteColor];
    [self.contentView addSubview:_progressView];
   
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_titleLbl.mas_right).offset(5);
        make.centerY.equalTo(self->_titleLbl.mas_centerY);
        make.width.mas_equalTo(90);
    }];
    
}

- (void)passThedataTextLabel:(NSString *)text DetailStr: (NSString *)detail Progress:(CGFloat)progress
{
   
    
    float floatString = [detail floatValue];
    if (floatString == 0.0f)
    {
        _sorcelbl.text = @"";
    }else
    {
       
        int score = floatString*100;
        detail = [NSString stringWithFormat:@"%d%%",score];
        _sorcelbl.text = detail;
        
    }
    
    _progressView.progress = progress;
     _titleLbl.text = text;
   
}

@end

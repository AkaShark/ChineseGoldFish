//
//  GFShowAllImageCollectionViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowAllImageCollectionViewCell.h"
#import "GFShowImageModel.h"
#import "UIImageView+WebCache.h"
@interface GFShowAllImageCollectionViewCell()

@property (nonatomic,strong) UIImageView *showImgV;
@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,strong) UIImageView *eyeImgV;
@property (nonatomic,strong) UILabel *numberLbl;
@property (nonatomic,strong) UILabel *typeLbl;
@property (nonatomic,strong) UIImageView *typeImgV;

@end

@implementation GFShowAllImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUI];        
        self.layer.borderColor = [UIColor colorWithHexString:@"eeedec"].CGColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)setUI
{
    _showImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:_showImgV];
    
    [_showImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@1);
        make.height.equalTo(@120);
        make.right.equalTo(@-1);
    }];
    
    
    _eyeImgV = [[UIImageView alloc] init];
    _eyeImgV.image = [UIImage imageNamed:@"eye-showImage"];
    [self.contentView  addSubview:_eyeImgV];
    
    [_eyeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@5);
        make.width.height.equalTo(@20);
    }];
    
    _numberLbl = [[UILabel alloc] init];
    _numberLbl.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    _numberLbl.textColor = UIColor.whiteColor;
    _numberLbl.text = [NSString stringWithFormat:@"%d",arc4random()% 100];
    [self.contentView  addSubview:_numberLbl];
    
    [_numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.eyeImgV.mas_top).offset(5);
        make.left.equalTo(self.eyeImgV.mas_right).offset(5);
    }];
    
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _titleLbl.textColor = [UIColor blackColor];
    _titleLbl.numberOfLines = 0;
    [self.contentView  addSubview:_titleLbl];
    
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showImgV.mas_bottom).offset(5);
        make.left.equalTo(self.eyeImgV.mas_left).offset(0);
        make.right.equalTo(self);
    }];
    
    _typeImgV = [[UIImageView alloc] init];
    _typeImgV.image = [UIImage imageNamed:@"typeImage"];
    [self.contentView  addSubview:_typeImgV];
    
    [_typeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.eyeImgV.mas_left).offset(0);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(5);
        make.width.height.equalTo(@15);
        make.bottom.equalTo(self);
    }];
    
    _typeLbl = [[UILabel alloc] init];
    _typeLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    _typeLbl.textColor = StandBackColor;
    [NSString translation:@"金鱼美图"
              CallbackStr:^(NSString * _Nonnull str) {
                  _typeLbl.text = str;
              }];
//    _typeLbl.text = @"金鱼美图";
    [self.contentView  addSubview:_typeLbl];
    [_typeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImgV.mas_right).offset(5);
        make.top.equalTo(self.typeImgV.mas_top).offset(0);
        make.bottom.equalTo(self.typeImgV.mas_bottom).offset(0);
//        make.bottom.equalTo(@0);
    }];
    
}

//setter
- (void)setModel:(GFShowImageModel *)model
{
    _model = model;
    [_showImgV sd_setImageWithURL:[NSURL URLWithString:model.contentUrl] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    [NSString translation:model.contentTitle CallbackStr:^(NSString * _Nonnull str) {
        self->_titleLbl.text = str;
    }];
    
    [_titleLbl.superview layoutIfNeeded];
    [_titleLbl layoutIfNeeded];
    
}

@end

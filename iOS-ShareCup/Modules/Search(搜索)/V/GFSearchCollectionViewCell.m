//
//  GFSearchCollectionViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/30.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFSearchCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface GFSearchCollectionViewCell ()

@property (nonatomic,strong) UIImageView *fishImgV;
@property (nonatomic,strong) UILabel *nameLbl;

@end

@implementation GFSearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setUpUI
{
    _fishImgV = [[UIImageView alloc] init];
    _fishImgV.layer.cornerRadius = 8;
    _fishImgV.layer.masksToBounds = YES;
    _fishImgV.image = [UIImage imageNamed:@"noDataImage"];
    [self.contentView addSubview:_fishImgV];
    [_fishImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [_fishImgV.superview layoutIfNeeded];
    [_fishImgV layoutIfNeeded];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    _nameLbl.backgroundColor = StandBackColor;
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.frame = CGRectMake(0, 0, _fishImgV.frame.size.width, _fishImgV.frame.size.height);
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLbl];
//    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.fishImgV.mas_bottom);
//        make.left.equalTo(self.fishImgV).offset(5);
//    }];
}

- (void)setUIDataImage:(NSString *)imageName AndName:(NSString *)name
{
    
    [NSString translation:name CallbackStr:^(NSString * _Nonnull str) {
        self.nameLbl.text = str;
    }];
    [_fishImgV sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    
}


@end

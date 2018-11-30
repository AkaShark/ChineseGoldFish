//
//  GFShowDetailSectionHead.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/3.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDetailSectionHead.h"
#import "UIImageView+WebCache.h"

@interface GFShowDetailSectionHead ()

@property (nonatomic,strong) UILabel *vartiyLbl;
@property (nonatomic,strong) UIImageView *imgV;

@end

@implementation GFShowDetailSectionHead

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

// 设置UI
- (void)setUpUI
{
    _imgV = [UIImageView new];
    [self addSubview:_imgV];
    
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@0);
        make.width.mas_offset(39);
        make.height.mas_offset(23);
    }];
    
    _vartiyLbl = [UILabel new];
    _vartiyLbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    _vartiyLbl.textColor = [UIColor blackColor];
    [self addSubview:_vartiyLbl];
    
    [_vartiyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV.mas_top);
        make.left.equalTo(self.imgV.mas_right).offset(10);
    }];
}

- (void)setUpDataImageUrl:(NSString *)imageUrl vartiyName:(NSString *)varity
{
    _imgV.image = [UIImage imageNamed:imageUrl];
    [NSString translation:varity CallbackStr:^(NSString * _Nonnull str) {
        self.vartiyLbl.text = str;
    }];
    
    
    [_vartiyLbl layoutIfNeeded];
    [_vartiyLbl.superview layoutIfNeeded];
    
}

@end

//
//  GFShowAllCollectionViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowAllCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface GFShowAllCollectionViewCell()

@property (nonatomic,strong) UILabel *nameLbl;




@end


@implementation GFShowAllCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    _showImgV = [[UIImageView alloc] init];
    [self.contentView addSubview:_showImgV];
    
    [_showImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.left.equalTo(@0);
    }];
    
    _nameLbl = [UILabel new];
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    _nameLbl.backgroundColor = StandBackColor;
    _nameLbl.layer.cornerRadius = 4;
    _nameLbl.layer.masksToBounds = YES;
    _nameLbl.numberOfLines = 0 ;
    [self.contentView addSubview:_nameLbl];
    
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@2);
        make.top.equalTo(@0);
        make.width.equalTo(self.showImgV.mas_width).offset(-3);
    }];
    
   
    
}

- (void)setModel:(GFShowDetailModel *)model
{
    __weak typeof(self) weakSelf = self;
    NSString *str = model.imageUrl;
    NSArray *arr = [str componentsSeparatedByString:@","];
    
    [_showImgV sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];

    [NSString translation:model.className CallbackStr:^(NSString * _Nonnull str) {
        weakSelf.nameLbl.text = str;
    }];
    
    
    
    
    [_nameLbl.superview layoutIfNeeded];
}



@end

//
//  GFVideoListTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/28.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFVideoListTableViewCell.h"

@interface GFVideoListTableViewCell()

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIImageView *headImgV;


@end

@implementation GFVideoListTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _headImgV = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImgV];
    
    [_headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@8);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
        make.bottom.equalTo(@(-10));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgV.mas_right).offset(8);
        make.top.equalTo(self.headImgV.mas_top);
        make.width.equalTo(self).offset(10);
    }];
}

- (void)setHeadImage:(NSString *)image Name:(NSString *)name
{
    _headImgV.image = [UIImage imageNamed:image];
    _nameLabel.text = name;
}
@end

//
//  goldFishBaseTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "goldFishBaseTableViewCell.h"
@interface goldFishBaseTableViewCell()
//介绍label
@property (nonatomic,strong) UILabel *customDetailLabel;

@end

@implementation goldFishBaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    
}

- (UILabel *)customDetailLabel
{
    if (!_customDetailLabel)
    {
        _customDetailLabel = [UILabel new];
        [self addSubview:_customDetailLabel];
        _customDetailLabel.font = SYSTEMFONT(14);
        _customDetailLabel.textColor = KGrayColor;
        _customDetailLabel.textAlignment = NSTextAlignmentRight;
        [_customDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _customDetailLabel;
}

@end

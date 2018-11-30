//
//  GFMyCollectionTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/11/13.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFMyCollectionTableViewCell.h"

@implementation GFMyCollectionTableViewCell

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
    }
    
    return _mainImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
    }
    return _detailLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    GFMyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];
    if (cell==nil) {
        cell = [[GFMyCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectionCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
       
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainImageView.mas_top);
        make.left.equalTo(self.mainImageView.mas_right).offset(8);
            make.right.equalTo(self.mas_right).offset(-8);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(20);
        }];
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.font = [UIFont systemFontOfSize:12];
        self.detailLabel.numberOfLines = 2;
        [self.contentView addSubview:self.detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
            make.bottom.equalTo(self.detailLabel.mas_top).offset(20);
        }];
    }
    return self;
}

@end

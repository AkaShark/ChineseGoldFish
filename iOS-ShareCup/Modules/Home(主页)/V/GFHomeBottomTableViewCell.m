//
//  GFHomeBottomTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 12/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFHomeBottomTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface GFHomeBottomTableViewCell()

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *bottomTitleLbl;
@property (nonatomic,strong) UILabel *detailLbl;


@end
@implementation GFHomeBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
   
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 10;
    _headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImageView];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.height.equalTo(@90);
        make.width.equalTo(@120);
    }];
    
    
    _bottomTitleLbl = [[UILabel alloc] init];
    _bottomTitleLbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    _bottomTitleLbl.textColor = UIColor.blackColor;
    _bottomTitleLbl.numberOfLines = 0;
    [self.contentView addSubview:_bottomTitleLbl];
    
    [_bottomTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(8);
        make.right.equalTo(@3);
        make.top.equalTo(self.headImageView).offset(-10);
    }];
    
    _detailLbl = [[UILabel alloc]init];
    _detailLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _detailLbl.textColor = [UIColor lightGrayColor];
    _detailLbl.numberOfLines = 0;
    _detailLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomTitleLbl);
        make.right.equalTo(@3);
        make.bottom.equalTo(@0);
        make.top.equalTo(self.bottomTitleLbl.mas_bottom).offset(5);
        make.height.equalTo(@80);
    }];
    
    
}

// 设置数据
- (void)upDataTheData:(NSString *)imageName title:(NSString *)titleStr andDetail:(NSString *)detail
{
    if ([imageName isEqualToString:@""])
    {
        _headImageView.image = [UIImage imageNamed:@"noDataImage"];
    }
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageName]
                 placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    _bottomTitleLbl.text = titleStr;
    _detailLbl.text = detail;
}


- (NSString *)titleStr
{
    if (!_titleStr)
    {
        _titleStr = [[NSString alloc] init];
    }
    return _titleStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

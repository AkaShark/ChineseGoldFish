//
//  GFShowDocumentTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/14.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDocumentTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface GFShowDocumentTableViewCell()

@property (nonatomic,strong) UIImageView *backImgV;
@property (nonatomic,strong) UILabel *titleLbl;

@end

@implementation GFShowDocumentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
       
    }
    return self;
}

- (void)setUpUI
{
    _backImgV = [[UIImageView alloc] init];
    [self addSubview:_backImgV];
    [_backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];

}

- (void)setUIDataTitleStr:(NSString *)str andImageStr:(NSString *)imageStr
{
    _backImgV.image = [UIImage imageNamed:imageStr];
    [self.contentView layoutIfNeeded];
    [self.contentView.superview layoutIfNeeded];

    //    刷新后再去设置这个部分的b内容
    //    某认的maskToBounds是true这样的话造成了 生成的阴影直接被切掉了 所有要设置成no
    self.layer.masksToBounds = false;
    self.layer.shadowOffset = CGSizeMake(3, 4); //x向右移动3 y向下移动4
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 3;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 8;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 30;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 60;
    [super setFrame:frame];
}



@end

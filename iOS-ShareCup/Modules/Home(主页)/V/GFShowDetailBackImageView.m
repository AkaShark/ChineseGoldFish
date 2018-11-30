//
//  GFShowDetailBackImageView.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/25.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDetailBackImageView.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+WebCache.h"
@interface GFShowDetailBackImageView ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *classDetailLbl;
@property (nonatomic,strong) UILabel *classNameLbl;



@end

@implementation GFShowDetailBackImageView
{
    float _lblY;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
//        339
        make.height.equalTo(@339);
    }];
    
    _classNameLbl = [UILabel new];
    _classNameLbl.font = [UIFont systemFontOfSize:25 weight:UIFontWeightHeavy];
    _classNameLbl.textColor = StandBackColor;
    [self addSubview:_classNameLbl];
    
    [_classNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView);
        make.bottom.equalTo(self.imageView.mas_bottom);

    }];
    
    
    _classDetailLbl = [[UILabel alloc] init];
//    设置多行显示
    _classDetailLbl.numberOfLines = 0;
    _classDetailLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    _classDetailLbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    _classDetailLbl.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_classDetailLbl];
    [_classDetailLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    
}
//
- (void)setUpUI:(NSString *)image AndDetail:(NSString *)detail ClassName:(NSString *)name
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    
    NSMutableParagraphStyle*paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.alignment=NSTextAlignmentLeft;//对齐
    
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = self.classDetailLbl.font.pointSize*2;
    paraStyle.firstLineHeadIndent= emptylen;//首行缩进
    paraStyle.tailIndent=-10.0f;//行尾缩进
    paraStyle.headIndent=10.0f;//行首缩进
    paraStyle.lineSpacing=2.0f;//行间距
    
    [NSString translation:detail CallbackStr:^(NSString * _Nonnull str) {
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:str attributes:@{NSParagraphStyleAttributeName:paraStyle}];
          self.classDetailLbl.attributedText= attrText;
        
    }];

    [NSString translation:name CallbackStr:^(NSString * _Nonnull str) {
        self.classNameLbl.text = str;
    }];
    
    
    [_classNameLbl layoutIfNeeded];
    [_classNameLbl.superview layoutIfNeeded];
    [_classDetailLbl layoutIfNeeded];
    [_classDetailLbl.superview layoutIfNeeded];
    
     _lblY = _classNameLbl.origin.y-10;
}
//获取到offset
- (void)whenScrollGetOffset:(CGPoint )offest
{
    float luochaY = _imageView.size.height-64;
//    NSLog(@"%f",offest.y);
    
    CGFloat offSetY = offest.y;
    if (offSetY <= 0)
    {
        _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1,1);
//        _classNameLbl.textColor = [UIColor whiteColor];
//        _classNameLbl.frame = CGRectMake(20, _imageView.size.height - 60, _classNameLbl.width, 44);
    }
    else if (offSetY >luochaY)
    {
       _classNameLbl.frame = CGRectMake(20 + offSetY / luochaY * ((KScreenWidth- 40 - _classNameLbl.width) / 2), 20, _classNameLbl.width, 44);
        _classNameLbl.textColor = StandBackColor;
    }
    else{
         _classNameLbl.frame = CGRectMake(offSetY / luochaY * ((KScreenWidth - _classNameLbl.width) / 2),_lblY, _classNameLbl.width, 44);
          _imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + 0.4 * (offSetY / luochaY), 1);
        _classNameLbl.transform = CGAffineTransformScale(CGAffineTransformIdentity,  1-0.3 * (offSetY / luochaY), 1-0.3 * (offSetY / luochaY));
        
    }
    
}

@end

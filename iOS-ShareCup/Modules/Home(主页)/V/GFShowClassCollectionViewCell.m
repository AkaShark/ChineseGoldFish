//
//  GFShowClassCollectionViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowClassCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "GFShowDetailModel.h"
@interface GFShowClassCollectionViewCell()<UIGestureRecognizerDelegate>


@property (nonatomic,strong) UILabel *classNameLbl;

@property (nonatomic,strong) UILabel *detialLbl;

@end



@implementation GFShowClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，
       
    }
    return self;
}


- (void)setUpUI
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    添加pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    pan.delegate = self;
    [pan addTarget:self action:@selector(changeScaleByTap:)];
    [view addGestureRecognizer:pan];
    
    [self addSubview:view];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    _classImage = [UIImageView new];
    [view addSubview:_classImage];
    [_classImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@100);
    }];
    
    _classNameLbl = [UILabel new];
    _classNameLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _classNameLbl.textColor = [UIColor blackColor];
    [view addSubview:_classNameLbl];
    [_classNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.classImage.mas_bottom).offset(3);
        make.left.equalTo(self.classImage).offset(8);
    }];
    
    _detialLbl = [UILabel new];
    _detialLbl.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    _detialLbl.numberOfLines = 0;
    _detialLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    _detialLbl.textColor = StandBackColor;
    [view addSubview:_detialLbl];
    [_detialLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.classNameLbl).offset(13);
        make.right.equalTo(self);
        make.left.equalTo(self.classNameLbl.mas_left);
        make.bottom.equalTo(self);
    }];
   
   
}
// model的set方法
- (void)setModel:(GFShowDetailModel *)model
{
    _model = model;
    
    [self.classImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
    
    [NSString translation:model.className CallbackStr:^(NSString * _Nonnull str) {
        self.classNameLbl.text = str;
    }];
    [NSString translation:model.detailStr CallbackStr:^(NSString * _Nonnull str) {
        self.detialLbl.text = str;
    }];
//    self.classNameLbl.text = model.className;
//    NSString *str = model.detailStr;
    
//    str = [str substringToIndex:10];
//    str = [NSString stringWithFormat:@"%@....",str];
//    self.detialLbl.text = str;
}

// 改变缩放
- (void)changeScaleByTap:(UIPanGestureRecognizer *)event
{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }completion:^(BOOL finished) {

    }];
    if (event.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {

        }];
    }
    
    
}

// 手势代理方法 返回两个手势都接受 代理方法返回yes的话说明手势会一直往下传不管该层是否响应了
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    return YES;
}



@end

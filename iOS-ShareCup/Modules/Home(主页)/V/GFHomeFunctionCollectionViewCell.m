//
//  GFHomeFunctionCollectionViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 11/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFHomeFunctionCollectionViewCell.h"
#import "GFLayer.h"

@interface GFHomeFunctionCollectionViewCell()
@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation GFHomeFunctionCollectionViewCell



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
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    [_backImageView addGestureRecognizer:tap];
//    _backImageView.backgroundColor = [UIColor greenColor];
   
    [self addSubview:_backImageView];
    
    
    
    _backImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    _backImageView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _backImageView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    _backImageView.layer.shadowRadius = 4;//阴影半径，默认
    
    
}

//点击图片
- (void)clickImage: (UITapGestureRecognizer *)tap
{
    self.callBack();
}
//
- (void)setUpData:(NSString *)imageName
{
    
    _backImageView.image = [UIImage imageNamed:imageName];
    
}


@end

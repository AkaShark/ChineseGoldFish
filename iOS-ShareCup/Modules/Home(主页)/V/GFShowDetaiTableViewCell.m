//
//  GFShowDetaiTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/25.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDetaiTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDPhotoBrowser.h"

//添加头文件 引入图片浏览器
@interface GFShowDetaiTableViewCell()<SDPhotoBrowserDelegate>

{
    BOOL isFirst;
}
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) UILabel *detailLbl;
@property (nonatomic,copy) NSArray *array;
@end

@implementation GFShowDetaiTableViewCell

- (NSMutableArray *)imageViewArray
{
    if (!_imageViewArray)
    {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        isFirst = YES;
    }
    return self;
}


// set方法
- (void)setModel:(GFShowVarietyModel *)model
{
    
    _model = model;
    NSString *str = model.imageURl;
    NSArray *arr = [str componentsSeparatedByString:@","];
    _array = arr;
    [self setUpUIWtihImages:arr AndDetial:model.detailStr];
}

// 绘制UI
- (void)setUpUIWtihImages:(NSArray *)array AndDetial:(NSString *)detial
{
    
    self.imageViewArray = [[NSMutableArray alloc] init];
//
    if (array.count <= 1 && isFirst == YES)
    {
        isFirst = NO;
        UIImageView *contentImgView = [[UIImageView alloc] init];
        [contentImgView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        contentImgView.userInteractionEnabled = YES;
        [contentImgView addGestureRecognizer:tap];
        [self.imageViewArray addObject:contentImgView];
        [self.contentView addSubview:contentImgView];
        
        [contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(@20).priorityHigh();
            make.right.equalTo(@-40);
//            make.left.equalTo(@40);
            make.height.equalTo(@200);
        }];
    }
    else
    {
        for (int i=0 ; i<array.count; i++)
        {
            UIImageView *contentImgView = [[UIImageView alloc] init];
            [contentImgView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
             UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            contentImgView.userInteractionEnabled = YES;
            [contentImgView addGestureRecognizer:tap];
            contentImgView.tag = i;
            [self.imageViewArray addObject:contentImgView];
            [self.contentView addSubview:contentImgView];
            
            if (i==0)
            {
                [contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.contentView.mas_centerX);
                    make.top.equalTo(@20).priorityHigh();
                    make.right.equalTo(@-40);
//                    make.left.equalTo(@40);
                    make.height.equalTo(@200);
                }];
            }
            else
            {
                UIImageView *imageView = self.imageViewArray[i-1];
                [contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.contentView.mas_centerX);
                    make.top.equalTo(imageView.mas_bottom).offset(20).priorityHigh();
                    make.right.equalTo(@-40);
//                    make.left.equalTo(@40);
                    make.height.equalTo(@200);
                }];
            }
            
        }
    }
//    __weak typeof(self) weakSelf = self;
    _detailLbl = [[UILabel alloc] init];
    _detailLbl.textColor = [UIColor blackColor];
    _detailLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    //    设置多行显示
    _detailLbl.numberOfLines = 0;
    _detailLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
//    设置首行缩进
    NSMutableParagraphStyle*paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.alignment=NSTextAlignmentLeft;//对齐
    paraStyle.headIndent=15.0f;//整体缩进
    paraStyle.tailIndent = -15.0f;//整体缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = _detailLbl.font.pointSize*2;
    paraStyle.firstLineHeadIndent= emptylen;//首行缩进
    paraStyle.lineSpacing=3.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:detial attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    _detailLbl.attributedText= attrText;
    
    UIImageView *imageView = [self.imageViewArray lastObject];
    
    [self.contentView addSubview:_detailLbl];

    
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-10).priorityHigh();
    }];
//    立即刷新
    [_detailLbl.superview layoutIfNeeded];
    
}
// 图片点击
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.contentView;
    browser.imageCount = self.array.count;
    browser.delegate = self;
    [browser show];
}
#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.array[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.imageViewArray[index];
    return imageView.image;
}

@end

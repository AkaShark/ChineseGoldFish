
//
//  GFimagePickOverLayView.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/3.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "LSHimagePickOverLayView.h"

@implementation LSHimagePickOverLayView

- (instancetype) init{
    if (self = [super init])
    {
        [self UI_Config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self UI_Config];
    }
    return self;
}

//设置UI
- (void)UI_Config
{
    self.backgroundColor = [UIColor blackColor];
    [self buttomBar];
    [self cancelButton];
    [self tabkePictureBtn];
    
//    [self topbar];
//    [self resetTopBar];
    
}

- (void)layoutSubviews{
    
    _tabkePictureBtn.frame = CGRectMake(self.width / 2.0 - 30, 7.5, 55, 55);
    _tabkePictureBtn.centerY = _buttomBar.height / 2.0;
    _cancelButton.frame = CGRectMake(self.width - 70, 0, 55, 55);
    _cancelButton.centerY = _buttomBar.height / 2.0;
    _imageLibView.frame = CGRectMake(10, 0, 55, 55);
    _imageLibView.centerY = _buttomBar.height / 2.0;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"响应链");
    
    return view;
}

#pragma mark - 设置闪光灯的方法



#pragma mark - Private Methos
- (void)hiddenSelfAndBar:(BOOL)hidden
{
    self.hidden = hidden;
//    self.topbar.hidden = hidden;
    self.buttomBar.hidden = hidden;
}






#pragma mark- setter & getter
//重写get方法 懒加载
- (UIView *)buttomBar
{
    if (!_buttomBar) {
        _buttomBar = [[UIView alloc] init];
        _buttomBar.backgroundColor = [UIColor blackColor];
        [self addSubview:_buttomBar];
    }
    return _buttomBar;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton){
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setTextColor:UIColor.whiteColor];
        [_buttomBar addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)tabkePictureBtn
{
    if (!_tabkePictureBtn)
    {
#define ZFBundle_Name @"testForBundle.bundle"
#define ZFBundle_Path [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:ZFBundle_Name]
#define ZFBundle [NSBundle bundleWithPath:ZFBundle_Path]
      
        NSString *bundleName = @"GFTakePhoto.Bundle";
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        _tabkePictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tabkePictureBtn setImage:[UIImage imageNamed:@"camera_Photo" inBundle:bundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [_tabkePictureBtn.titleLabel setTextColor:UIColor.whiteColor];
        [_buttomBar addSubview:_tabkePictureBtn];
    }
    return _tabkePictureBtn;
}
- (UIImageView *)imageLibView{
    if (!_imageLibView)
    {
        _imageLibView = [[UIImageView alloc] init];
        _imageLibView.userInteractionEnabled = YES;
        [_buttomBar addSubview:_imageLibView];
    }
    return _imageLibView;
}

//- (UIView *)topbar{
//    if (!_topbar)
//    {
//        _topbar = [[UIView alloc] init];
//        _topbar.backgroundColor = [UIColor blackColor];
//        [self addSubview:_topbar];
//    }
//    return _topbar;
//}

- (UIImageView *)focusView
{
    if (!_focusView)
    {
        _focusView = [[UIImageView alloc] init];
        _focusView.frame = CGRectMake(0, 0, 80, 80);
        _focusView.layer.borderColor = RGB(252, 208, 52, 1.0).CGColor;
        _focusView.layer.borderWidth = 2.0f;
        _focusView.hidden = YES;
        _focusView.alpha = 0.0;
        [self addSubview:_focusView];
    }
    return _focusView;
}






@end

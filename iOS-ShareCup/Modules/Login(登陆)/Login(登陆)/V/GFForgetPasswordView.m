//
//  GFForgetPasswordView.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/25.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFForgetPasswordView.h"
#import "Masonry.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation GFForgetPasswordView

- (void)setUpTheUI{
    
    _phoneNumTextField = [[UITextField alloc]init];
    [NSString translation:@"请填写手机号" CallbackStr:^(NSString * _Nonnull str) {
        _phoneNumTextField.placeholder = str;
    }];
//    _phoneNumTextField.placeholder = @"请填写手机号";
    _phoneNumTextField.layer.borderWidth = 0.5;
    _phoneNumTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phoneNumTextField.layer.cornerRadius = 10;
    [self addSubview:_phoneNumTextField];
    [_phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(100);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
    make.bottom.equalTo(self.phoneNumTextField.mas_top).offset(50);
        
    }];
    
    _numTextField = [[UITextField alloc]init];
    [NSString translation:@"请输入验证码" CallbackStr:^(NSString * _Nonnull str) {
        _numTextField.placeholder = str;
    }];
//    _numTextField.placeholder = @"请输入验证码";
    _numTextField.layer.borderWidth = 0.5;
    _numTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _numTextField.layer.cornerRadius = 10;
    [self addSubview:_numTextField];
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_phoneNumTextField).offset(80);
        make.left.equalTo(self->_phoneNumTextField);
        make.size.equalTo(self->_phoneNumTextField);
    }];
    
    _PswTextField = [[UITextField alloc]init];
    [NSString translation:@"请设置新密码" CallbackStr:^(NSString * _Nonnull str) {
        _PswTextField.placeholder = str;
    }];
//    _PswTextField.placeholder = @"请设置新密码";
    _PswTextField.layer.borderWidth = 0.5;
    _PswTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _PswTextField.layer.cornerRadius = 10;
    [self addSubview:_PswTextField];
    [_PswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_numTextField).offset(80);
        make.left.equalTo(self->_phoneNumTextField);
        make.size.equalTo(self->_phoneNumTextField);
    }];
    
    _sendNumBtn = [[UIButton alloc]init];
    _sendNumBtn.layer.borderWidth = 0.5;
    _sendNumBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [NSString translation:@"发送验证码" CallbackStr:^(NSString * _Nonnull str) {
        [_sendNumBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_sendNumBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _sendNumBtn.layer.cornerRadius = 10;
    [_sendNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _sendNumBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_sendNumBtn addTarget:self action:@selector(sendNumBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendNumBtn];
    [_sendNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_phoneNumTextField);
        make.left.equalTo(self->_phoneNumTextField.mas_right).offset(-120);
        make.size.mas_equalTo(CGSizeMake(120,50));
    }];
    
}

- (void)sendNumBtnClick
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timered) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    self.count = 60;
}

- (void)timered{
    
    if (self.count>0) {
        [NSString translation:@"秒" CallbackStr:^(NSString * _Nonnull str) {
            _sendNumBtn.titleLabel.text = [NSString stringWithFormat:@"%d%@",_count--,str];
        }];
//        self.sendNumBtn.titleLabel.text = [NSString stringWithFormat:@"%d秒",self.count--];
    }else{
        [NSString translation:@"发送验证码" CallbackStr:^(NSString * _Nonnull str) {
            _sendNumBtn.titleLabel.text = str;
        }];
//        self.sendNumBtn.titleLabel.text = @"发送验证码";
        [_timer setFireDate:[NSDate distantFuture]];
    }
    
}

@end

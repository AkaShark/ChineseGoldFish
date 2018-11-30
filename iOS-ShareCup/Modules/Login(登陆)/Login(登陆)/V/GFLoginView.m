//
//  GFLoginView.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/23.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFLoginView.h"
#import "Masonry.h"
#import "GFRegisterViewController.h"
#import "GFForgetPasswordViewController.h"
#import "ReactiveCocoa.h"
@implementation GFLoginView

- (void)setUpTheUI{
    
    @weakify(self);
    //给view添加背景图
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]];
    
    
//    _mainImageView = [[UIImageView alloc]init];
//    _mainImageView.image = [UIImage imageNamed:@"AppIcon"];
//    _mainImageView.layer.borderWidth = 0.5;
//    _mainImageView.layer.masksToBounds = YES;
//    _mainImageView.layer.borderColor = [UIColor clearColor].CGColor;
//    _mainImageView.layer.cornerRadius = 40;
//    _mainImageView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:_mainImageView];
//    
//    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(130);
//        make.centerX.equalTo(self.mas_centerX);
//        //添加大小约束（make就是要添加约束的控件_mainImageView）
//        make.size.mas_equalTo(CGSizeMake(80, 80));
//        
//    }];
    
    
    _userImageView = [[UIImageView alloc]init];
    _userImageView.image = [UIImage imageNamed:@"用户.png"];
    [self  addSubview:_userImageView];
    
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@350);
        make.left.equalTo(self).offset(35);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _userTextField = [[UITextField alloc]init];
    [NSString translation:@"请输入手机号" CallbackStr:^(NSString * _Nonnull str) {
        NSAttributedString *userStr = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:_userTextField.font}];
        _userTextField.attributedPlaceholder = userStr;
    }];
//    NSAttributedString *userStr = [[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:_userTextField.font}];
//    _userTextField.attributedPlaceholder = userStr;
//    对于textFiled的监听
    [[_userTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(id x) {
//        判断是否符合输入
        NSString *userName = ((UITextField *)x).text;
        NSString *pattern = @"^1+[3578]+\\d{9}";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatch = [pred evaluateWithObject:userName];
        if (isMatch)
        {
            weak_self.loginBtn.userInteractionEnabled = YES;
            weak_self.  loginBtn.backgroundColor = [UIColor colorWithRed:40/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
        }
        else
        {
//            HUD
            [NSString translation:@"请输入正确的手机号码" CallbackStr:^(NSString * _Nonnull str) {
                [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
            }];
//            [[HUDTA new] showHudWithStr:@"请输入正确的手机号码" AndOption:TAOverlayOptionOverlayTypeError];
            
            self.loginBtn.userInteractionEnabled = NO;
        }
    }];
    
    [self addSubview:_userTextField];
    
    [_userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userImageView.mas_top).offset(-13);
        make.left.equalTo(self->_userImageView.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-35);
        make.bottom.equalTo(self->_userTextField.mas_top).offset(50);
    }];
    
    _userView = [[UIView alloc]init];
    _userView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_userView];
    
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userImageView.mas_bottom).offset(8);
        make.left.equalTo(self->_userImageView).offset(-1);
        make.right.equalTo(self.userTextField.mas_right);
        make.bottom.equalTo(self->_userView.mas_top).offset(1);
    }];
    
    
    _pswImageView = [[UIImageView alloc]init];
//    _pswImageView.layer.borderWidth = 0.5;
//    _pswImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _pswImageView.image = [UIImage imageNamed:@"新密码.png"];
    [self addSubview:_pswImageView];
    [_pswImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userImageView.mas_bottom).offset(40);
        make.left.equalTo(self->_userImageView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _pswTextField = [[UITextField alloc]init];
    [NSString translation:@"请输入密码" CallbackStr:^(NSString * _Nonnull str) {
        NSAttributedString *pswStr = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:_pswTextField.font
                                                                                                     
                                                                                                     }];
        _pswTextField.attributedPlaceholder = pswStr;
    }];
//    NSAttributedString *pswStr = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:_pswTextField.font
//                                                                                              }];
//    _pswTextField.attributedPlaceholder = pswStr;
    _pswTextField.secureTextEntry = YES;
    [self addSubview:_pswTextField];
    [_pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_pswImageView.mas_top).offset(-13);
        make.left.equalTo(self->_userTextField);
        make.right.equalTo(self.mas_right).offset(-35);
        make.bottom.equalTo(self->_pswTextField.mas_top).offset(50);
    }];
    
    _pswView = [[UIView alloc]init];
    _pswView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_pswView];
    [_pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_pswImageView.mas_bottom).offset(8);
        make.left.equalTo(self->_pswImageView).offset(-1);
        make.right.equalTo(self.pswTextField.mas_right);
        make.bottom.equalTo(self->_pswView.mas_top).offset(1);
    }];
    
    _eyeBtn = [[UIButton alloc]init];
    [_eyeBtn setImage:[UIImage imageNamed:@"眼睛-闭.png"] forState:UIControlStateNormal];
    [[_eyeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIButton *btn = (UIButton *)x;
        if (btn.selected) {
            [weak_self.eyeBtn setImage:[UIImage imageNamed:@"眼睛-闭.png"] forState:UIControlStateNormal];
            
            weak_self.pswTextField.secureTextEntry = YES;
            
            btn.selected = NO;
            
        }else{
            [weak_self.eyeBtn setImage:[UIImage imageNamed:@"眼睛-睁.png"] forState:UIControlStateNormal];
            
            weak_self.pswTextField.secureTextEntry = NO;
            
            btn.selected = YES;
        }
    }];
    
    
    [self addSubview:_eyeBtn];
    [_eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_pswTextField).offset(13);
        make.left.equalTo(self->_pswTextField.mas_right).offset(-31);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _loginBtn = [[UIButton alloc]init];
//    _loginBtn.layer.borderWidth = 0.5;
//    _loginBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [_loginBtn setBackgroundColor:StandBackColor];
    _loginBtn.layer.cornerRadius = 7;
    [NSString translation:@"登录" CallbackStr:^(NSString * _Nonnull str) {
        [weak_self.loginBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    点击登陆按钮
//    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        weak_self.loginCallBack(weak_self.userTextField.text, weak_self.pswTextField.text);
//    }];
    
    
    
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_pswView.mas_bottom).offset(30);
        make.left.equalTo(self->_pswView);
        make.right.equalTo(self.mas_right).offset(-35);
        make.bottom.equalTo(self.loginBtn.mas_top).offset(50);
    }];
    
    
    _forgetBtn = [[UIButton alloc]init];
    [NSString translation:@"忘记密码？" CallbackStr:^(NSString * _Nonnull str) {
        [_forgetBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [_forgetBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[_forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        GFForgetPasswordViewController * forgetVC = [[GFForgetPasswordViewController alloc]init];
        
        [weak_self.viewController.navigationController pushViewController:forgetVC animated:YES];
    }];
    
    [self addSubview:_forgetBtn];
    
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_loginBtn.mas_bottom).offset(8);
        make.left.equalTo(self->_loginBtn.mas_left).offset(1);
        make.right.equalTo(self.loginBtn.mas_left).offset(90);
        make.bottom.equalTo(self.forgetBtn.mas_top).offset(20);
    }];
    
    _registerBtn = [[UIButton alloc]init];
    [NSString translation:@"还没有账号?注册" CallbackStr:^(NSString * _Nonnull str) {
        [_registerBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_registerBtn setTitle:@"还没有账号?注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        weak_self.regCallback();
    }];
    
    [self addSubview:_registerBtn];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_forgetBtn);
        make.left.equalTo(self->_loginBtn.mas_right).offset(-125);
        make.right.equalTo(self.loginBtn.mas_right).offset(-1);
        make.bottom.equalTo(self.registerBtn.mas_top).offset(20);
    }];
    
    
    UIButton *backBtn = [UIButton new];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.loginCallBack();
    }];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.left.equalTo(self).offset(20);
    }];
    
    
    
}



@end

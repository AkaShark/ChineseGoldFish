//
//  GFRegisterView.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/21.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFRegisterView.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD.h"
#import "GFLoginViewController.h"

@implementation GFRegisterView

- (void)setUpTheUI{
    //给view添加背景图
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]];
    
    //防止block中的循环引用
        __weak typeof(self)weakSelf = self;
//    _mainImageView = [[UIImageView alloc]init];
//    _mainImageView.layer.borderWidth = 0.5;
//    _mainImageView.layer.borderColor = [UIColor clearColor].CGColor;
//    _mainImageView.layer.masksToBounds = YES;
//    _mainImageView.backgroundColor = [UIColor whiteColor];
//    _mainImageView.layer.cornerRadius = 40;
//    _mainImageView.image = [UIImage imageNamed:@"AppIcon"];
//    [self addSubview:_mainImageView];
//
//    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.top.mas_offset(130);
////        make.left.mas_offset(170);
//        //添加大小约束（make就是要添加约束的控件_mainImageView）
//        make.size.mas_equalTo(CGSizeMake(80, 80));
//    }];
    
    
    _userImageView = [[UIImageView alloc]init];
    [_userImageView setImage:[UIImage imageNamed:@"用户.png"]];
    [self  addSubview:_userImageView];
    
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@350);
        make.left.equalTo(self).offset(35);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _userTextField = [[UITextField alloc]init];
    [NSString translation:@"请输入手机号" CallbackStr:^(NSString * _Nonnull str) {
        weakSelf.userTextField.placeholder = str;
    }];
//    _userTextField.placeholder = @"请输入手机号";
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
    
    
    _securityImageView = [[UIImageView alloc]init];
//    _securityImageView.layer.borderWidth = 0.5;
//    _securityImageView.layer.borderColor = [UIColor grayColor].CGColor;
    [_securityImageView setImage:[UIImage imageNamed:@"新验证码.png"]];
    [self addSubview:_securityImageView];
    [_securityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userImageView.mas_bottom).offset(40);
        make.left.equalTo(self->_userImageView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _securityTextField = [[UITextField alloc]init];
    [NSString translation:@"输入验证码" CallbackStr:^(NSString * _Nonnull str) {
        _securityTextField.placeholder = str;
    }];
//    _securityTextField.placeholder = @"输入验证码";
    [self addSubview:_securityTextField];
    [_securityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_securityImageView.mas_top).offset(-13);
        make.left.equalTo(self->_userTextField);
        make.right.equalTo(self.mas_right).offset(-35);
        make.bottom.equalTo(self->_securityTextField.mas_top).offset(50);
        
    }];
    
    _securityView = [[UIView alloc]init];
    _securityView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_securityView];
    [_securityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_securityImageView.mas_bottom).offset(8);
        make.left.equalTo(self->_securityImageView).offset(-1);
    make.right.equalTo(self.securityTextField.mas_right);
        make.bottom.equalTo(self->_securityView.mas_top).offset(1);
    }];
    
    _pswImageView = [[UIImageView alloc]init];
//    _pswImageView.layer.borderWidth = 0.5;
//    _pswImageView.layer.borderColor = [UIColor grayColor].CGColor;
    [_pswImageView setImage:[UIImage imageNamed:@"新密码.png"]];
    [self addSubview:_pswImageView];
    [_pswImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_securityImageView.mas_bottom).offset(40);
        make.left.equalTo(self->_userImageView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _pswTextField = [[UITextField alloc]init];
    [NSString translation:@"输入密码" CallbackStr:^(NSString * _Nonnull str) {
        _pswTextField.placeholder = str;
    }];
//    _pswTextField.placeholder = @"输入密码";
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
    
    _registerBtn = [[UIButton alloc]init];
    _registerBtn.backgroundColor = [UIColor colorWithRed:40/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    _registerBtn.layer.cornerRadius = 7;
    [NSString translation:@"注册" CallbackStr:^(NSString * _Nonnull str) {
        [_registerBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_pswView.mas_bottom).offset(30);
        make.left.equalTo(self->_pswView);
        make.right.equalTo(self.pswTextField.mas_right);
    make.bottom.equalTo(self.registerBtn.mas_top).offset(50);
    }];
    
    
    _gainBtn = [[UIButton alloc]init];
    [NSString translation:@"获取验证码" CallbackStr:^(NSString * _Nonnull str) {
        [_gainBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_gainBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_gainBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _gainBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _gainBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _gainBtn.layer.borderWidth = 0.5;
    _gainBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _gainBtn.layer.cornerRadius = 5;
    [_gainBtn addTarget:self action:@selector(gainBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_gainBtn];
    
    [_gainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_securityTextField.mas_top).offset(6);
        make.left.equalTo(self->_securityTextField.mas_right).offset(-82);
    make.right.equalTo(self.securityTextField.mas_right).offset(1);
        make.bottom.equalTo(self.gainBtn.mas_top).offset(30);
    }];
    
    _loginBtn = [[UIButton alloc]init];
    [NSString translation:@"已有账号?返回登录" CallbackStr:^(NSString * _Nonnull str) {
        [_loginBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_loginBtn setTitle:@"已有账号?返回登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_registerBtn.mas_bottom).offset(8);
        make.left.equalTo(self->_registerBtn.mas_right).offset(-135);
        make.right.equalTo(self.registerBtn.mas_right).offset(-3);
        make.bottom.equalTo(self.loginBtn.mas_top).offset(20);
    }];
}

- (void)gainBtnClick{
    
    [NSString translation:@"正在发生短信" CallbackStr:^(NSString * _Nonnull str) {
        [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeActivityBlur];
    }];
    
//    [[HUDTA new] showHudWithStr:@"正在发生短信" AndOption:TAOverlayOptionOverlayTypeActivityBlur];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userTextField.text zone:@"86" template:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"success");
        }else{
            NSLog(@"%ld",(long)error.code);
        }
    }];

    
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_TARGET_QUEUE_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [NSString translation:@"重新获取" CallbackStr:^(NSString * _Nonnull str) {
                    [self.gainBtn setTitle:str forState:UIControlStateNormal];
                }];
//                [self.gainBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [NSString translation:@"秒" CallbackStr:^(NSString * _Nonnull str) {
                    [self.gainBtn setTitle:[NSString stringWithFormat:@"%@%@",strTime,str] forState:UIControlStateNormal];
                }];
//                [self.gainBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                self.gainBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                [UIView commitAnimations];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    

}

- (void)loginBtnClick{
    
    self.logincallBack();

}

- (void)registerBtnClick{
    
   
    
    [SMSSDK commitVerificationCode:self.securityTextField.text phoneNumber:self.userTextField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSString *urlStr = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish/Login.php?action=register&phone=%@&psd=%@&nickName=%@&signature=%@&area=%@",self.userTextField.text,self.pswTextField.text,@"用户",@"对金鱼的喜爱",@"张家口"];
            urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [POST_GET GET:urlStr parameters:nil succeed:^(id responseObject) {
                NSLog(@"%@",responseObject);
                
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSLog(@"%@",dict);
                NSString *str = dict[@"register_result"];
                NSLog(@"%@",str);
                NSString *str1 = [NSString stringWithFormat:@"%@",str];
                if ([str1 isEqualToString:@"1"]) {
                    
                    [NSString translation:@"注册成功" CallbackStr:^(NSString * _Nonnull str) {
                         [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeSuccess];
                    }];
//                    [[HUDTA new] showHudWithStr:@"注册成功" AndOption:TAOverlayOptionOverlayTypeSuccess];
                    
                    self.logincallBack();
                    
                }else if([str1 isEqualToString:@"0"]){
                    NSLog(@"用户已经存在");
                    [NSString translation:@"用户已经存在" CallbackStr:^(NSString * _Nonnull str) {
                        [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
                    }];
//                    [[HUDTA new] showHudWithStr:@"用户已经存在" AndOption:TAOverlayOptionOverlayTypeError];
                    
                }
            } failure:^(NSError *error) {
                NSLog(@"失败");
                [NSString translation:@"网络故障" CallbackStr:^(NSString * _Nonnull str) {
                    [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
                }];
//                [[HUDTA new] showHudWithStr:@"网络故障" AndOption:TAOverlayOptionOverlayTypeError];
            }];
        }else{
            NSLog(@"%ld",(long)error.code);
            [NSString translation:@"验证码错误" CallbackStr:^(NSString * _Nonnull str) {
                [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
            }];
//             [[HUDTA new] showHudWithStr:@"验证码错误" AndOption:TAOverlayOptionOverlayTypeError];
        }
    }];
    
}

- (void)ProgressBar{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        _HUD.progress = progress;
        usleep(50000);
    }
}


@end

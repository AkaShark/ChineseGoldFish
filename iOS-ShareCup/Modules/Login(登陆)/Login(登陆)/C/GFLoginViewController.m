//
//  GFLoginViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/23.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFLoginViewController.h"
#import "GFRegisterViewController.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface GFLoginViewController ()

@end

@implementation GFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView = [[GFLoginView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [_loginView setUpTheUI];
    
    [_loginView.loginBtn addTarget:self action:@selector(touchLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginView];
    
    __weak typeof(self) weakSelf = self;
    self.loginView.loginCallBack = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.loginView.regCallback = ^{
          GFRegisterViewController *registerVC = [[GFRegisterViewController alloc]init];
        registerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [weakSelf presentViewController:registerVC animated:YES completion:nil];
    };
    
   
    
}

//登陆
- (void)touchLogin
{
    
    [NSString translation:@"正在登陆" CallbackStr:^(NSString * _Nonnull str) {
        [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeActivityBlur];
    }];
//    [[HUDTA new] showHudWithStr:@"正在登陆" AndOption:TAOverlayOptionOverlayTypeActivityBlur];
    
    [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/Login.php?action=login&phone=%@&psd=%@",_loginView.userTextField.text,_loginView.pswTextField.text] parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"result"][0][@"login"]];
        
        self.nickName = [NSString stringWithFormat:@"%@",dic[@"result"][0][@"nickName"]];
        
        self.signature = [NSString stringWithFormat:@"%@",dic[@"result"][0][@"signature"]];
        
        self.area = [NSString stringWithFormat:@"%@",dic[@"result"][0][@"area"]];
        
        if ([str isEqualToString:@"fail"]){
            [NSString translation:@"您还没有完成注册，请先去注册哦" CallbackStr:^(NSString * _Nonnull str) {
                [[HUDTA new]showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
            }];
//            [[HUDTA new]showHudWithStr:@"您还没有完成注册，请先去注册哦" AndOption:TAOverlayOptionOverlayTypeError];
        }else if ([str isEqualToString:@"1"])
        {
//            通知登陆成功
            [self successLogin];
            [NSString translation:@"登陆成功" CallbackStr:^(NSString * _Nonnull str) {
                [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeSuccess];
            }];
//            [[HUDTA new] showHudWithStr:@"登陆成功" AndOption:TAOverlayOptionOverlayTypeSuccess];
        }
        else
        {
//            HUD账号密码错误
            [NSString translation:@"账号密码错误" CallbackStr:^(NSString * _Nonnull str) {
                [[HUDTA new] showHudWithStr:str AndOption:TAOverlayOptionOverlayTypeError];
            }];
//            [[HUDTA new] showHudWithStr:@"账号密码错误" AndOption:TAOverlayOptionOverlayTypeError];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//登陆成功
- (void)successLogin
{
    NSDictionary *dict = @{@"userName":_loginView.userTextField.text,@"isLogin":@"1",@"nickName":_nickName,@"signature":_signature,@"area":_area};
    
    NSLog(@"%@",dict);
    
    [[UserManager defaultManager] initWithDict:dict];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end

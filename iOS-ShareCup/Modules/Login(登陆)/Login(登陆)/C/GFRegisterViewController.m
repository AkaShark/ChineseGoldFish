//
//  GFRegisterViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/21.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFRegisterViewController.h"

#define WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface GFRegisterViewController ()

@end

@implementation GFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _registerView = [[GFRegisterView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [_registerView setUpTheUI];
    
    [self.view addSubview:_registerView];
    
    
    __weak typeof(self) weakSelf = self;
    _registerView.logincallBack = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
}

@end

//
//  GFInformationChangeViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/10/17.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFInformationChangeViewController.h"
#import "Masonry.h"
#import "GFPersonalInformationViewController.h"

@interface GFInformationChangeViewController ()<UITextFieldDelegate>

@end

@implementation GFInformationChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 0, 12, 12)];
    
    [NSString translation:@"保存" CallbackStr:^(NSString * _Nonnull str) {
        [saveBtn setTitle:str forState:UIControlStateNormal];
    }];
    
    [saveBtn setTintColor:[UIColor whiteColor]];
    
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveBtn];
    
    UIBarButtonItem  *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _changeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 40)];
    
    _changeTextField.delegate = self;
    
    _changeTextField.backgroundColor = [UIColor whiteColor];
    
    _changeTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    
    _changeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [_changeTextField becomeFirstResponder];
    
    [self.view addSubview:_changeTextField];
    
    _lineView = [[UIView alloc]init];
    
    _lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changeTextField.mas_bottom).offset(1);
        make.left.mas_equalTo(self.changeTextField.mas_left);
        make.width.mas_equalTo(self.changeTextField);
        make.height.mas_equalTo(1);
    }];
    
    _detailLabel = [[UILabel alloc]init];
    
    //    _detailLabel.text = @"好的名字可以让你的朋友更容易记住你";
    
    [_detailLabel setTextColor:[UIColor lightGrayColor]];
    
    _detailLabel.text = _labelStr;
    
    [self.view addSubview:_detailLabel];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom).offset(3);
        make.left.mas_equalTo(self->_lineView);
        make.width.equalTo(self.lineView);
        make.height.equalTo(@20);
    }];
}

- (void)saveBtnClick{
    
    if (self.passValueBlock) {
        self.passValueBlock(self.changeTextField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end

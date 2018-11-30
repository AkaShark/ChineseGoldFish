//
//  SYSuggestionViewController.m
//  师友
//
//  Created by kys-5 on 16/10/11.
//  Copyright © 2016年 kys-5. All rights reserved.
//

#import "SYSuggestionViewController.h"



@interface SYSuggestionViewController ()<UITextFieldDelegate,UITextViewDelegate>

//编辑作业
@property(nonatomic,strong)UITextView* groupTextView;

@end

@implementation SYSuggestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏遮挡问题
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout =UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.groupTextView];
    
    UIButton *submitbtn=[[UIButton alloc]initWithFrame:CGRectMake(10,KScreenHeight*0.4, KScreenWidth - 20, KScreenHeight/15)];
    [submitbtn setBackgroundColor:[UIColor colorWithHexString:@"0d9fff"]];
    [submitbtn  addTarget:self action:@selector(determineToPublishTask) forControlEvents:UIControlEventTouchUpInside];
    [NSString translation:@"提交意见" CallbackStr:^(NSString * _Nonnull str) {
        [submitbtn setTitle:str forState:UIControlStateNormal];
    }];
    submitbtn.layer.cornerRadius = 5.0;
    [self.view addSubview:submitbtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextView *)groupTextView {
    if (_groupTextView == nil) {
        _groupTextView = [[UITextView alloc]initWithFrame:CGRectMake(10,10,KScreenWidth-20,150)];
        _groupTextView.backgroundColor = [UIColor whiteColor];
        //_publishText.placeholder = @"请输入发表内容";
        _groupTextView.returnKeyType = UIReturnKeyDone;
        _groupTextView.layer.borderWidth = 2;
        _groupTextView.layer.borderColor = [UIColor colorWithHexString:@"0d9fff"].CGColor;
        _groupTextView.delegate = self;
    }
    return _groupTextView;
}

#pragma mark 判断？？？

-(void)determineToPublishTask{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"谢谢您的宝贵意见😊" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {    [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end




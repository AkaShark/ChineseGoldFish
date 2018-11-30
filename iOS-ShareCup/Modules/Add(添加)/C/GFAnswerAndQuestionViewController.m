//
//  GFAnswerAndQuestionViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/18.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFAnswerAndQuestionViewController.h"
#import "UITextView+Extension.h"
#import "IQKeyboardManager.h"

@interface GFAnswerAndQuestionViewController ()<UIImagePickerControllerDelegate,UINavigationBarDelegate>

@end

@implementation GFAnswerAndQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化控制器
    _imagePicker = [[UIImagePickerController alloc]init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.08)];
    
    _navView.backgroundColor = StandColor;
    
//    _window = [UIApplication sharedApplication].keyWindow;
    
    [self.view addSubview:_navView];
    
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width *0.05, self.view.frame.size.height * 0.035, 50, 30)];
    
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [NSString translation:@"取消" CallbackStr:^(NSString * _Nonnull str) {
        [_cancelBtn setTitle:str forState:UIControlStateNormal];
    }];
    
    
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navView addSubview:_cancelBtn];
    
    _finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.035, 50, 30)];
    
    [NSString translation:@"完成" CallbackStr:^(NSString * _Nonnull str) {
        [_finishBtn setTitle:str forState:UIControlStateNormal];
    }];
    
    [_finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navView addSubview:_finishBtn];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 37, self.view.frame.size.height * 0.03, 80, 30)];
    
    [NSString translation:@"编辑问题" CallbackStr:^(NSString * _Nonnull str) {
        [_titleLabel setText:str];
    }];
    
    [_titleLabel setTextColor:[UIColor lightGrayColor]];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navView addSubview:_titleLabel];
    
    _photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height * 0.08 + 10, self.view.frame.size.width-20, self.view.frame.size.height *0.15 +20)];
    
    _photoBtn.backgroundColor = [UIColor whiteColor];
    
    [NSString translation:@"添加图片（选填）" CallbackStr:^(NSString * _Nonnull str) {
        [_photoBtn setTitle:str forState:UIControlStateNormal];
    }];
    
//    [_photoBtn setTitle:@"添加图片（选填）" forState:UIControlStateNormal];
    
    _photoBtn.layer.borderWidth = 0.5;
    
    _photoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _photoBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [_photoBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [_photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_photoBtn];
    
    _questionTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height * 0.08 + 165, self.view.frame.size.width-20, self.view.frame.size.height *0.05)];
    
    _questionTextField.font = [UIFont systemFontOfSize:25.0];
    
    NSMutableParagraphStyle *style = [_questionTextField.defaultTextAttributes[NSParagraphStyleAttributeName]mutableCopy];//段落样式
    
    style.minimumLineHeight = _questionTextField.font.lineHeight - (_questionTextField.font.lineHeight - [UIFont systemFontOfSize:35.0].lineHeight)/2.0;//计算出高度差
    
    [NSString translation:@"请输入问题" CallbackStr:^(NSString * _Nonnull str) {
        _questionTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0],NSParagraphStyleAttributeName:style
                                                                                                                   }];
    }];
//    _questionTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入问题" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0],NSParagraphStyleAttributeName:style
//                                                                                                               }];
    
    _questionTextField.textColor = [UIColor blackColor];
    
    [self.view addSubview:_questionTextField];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height * 0.08 + 220, self.view.frame.size.width-20, 1)];
    
    _lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_lineView];
    
    _detailQTView = [[UITextView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height * 0.08 + 230, self.view.frame.size.width-20, self.view.frame.size.height * 0.7)];
    
    _detailQTView.backgroundColor = [UIColor whiteColor];
    
    [NSString translation:@"添加问题描述（选填）" CallbackStr:^(NSString * _Nonnull str) {
        [_detailQTView setPlaceholderWithText:str Color:[UIColor lightGrayColor]];
    }];
    
//    [_detailQTView setPlaceholderWithText:@"添加问题描述（选填）" Color:[UIColor lightGrayColor]];
    
    _detailQTView.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:_detailQTView];
    

    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (void)cancelBtnClick{
    
//    _window.removeAllSubviews;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)finishBtnClick{
//    _window.removeAllSubviews;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBtnClick{
    //打开相册
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

//选择某个图片时系统调用的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//通过key值获取到图片
    
    
    _photoBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _photoBtn.frame = CGRectMake(10, self.view.frame.size.height * 0.08 + 10, self.view.frame.size.width-20, self.view.frame.size.height *0.15 +60);
    
    _questionTextField.frame = CGRectMake(10, self.view.frame.size.height * 0.08 + 165 +40, self.view.frame.size.width-20, self.view.frame.size.height *0.05);
    
    _lineView.frame = CGRectMake(10, self.view.frame.size.height * 0.08 + 220 + 40, self.view.frame.size.width-20, 1);
    
    _detailQTView.frame = CGRectMake(10, self.view.frame.size.height * 0.08 + 230 + 40, self.view.frame.size.width-20, self.view.frame.size.height * 0.7);
    
    [_photoBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//取消选择图片时系统调用的代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

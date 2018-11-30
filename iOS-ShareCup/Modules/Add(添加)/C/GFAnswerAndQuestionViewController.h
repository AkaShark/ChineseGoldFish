//
//  GFAnswerAndQuestionViewController.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/18.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

@interface GFAnswerAndQuestionViewController : glodFishBaseViewController

@property (nonatomic,strong)UIView *navView;
@property (nonatomic,strong)UIButton *finishBtn;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *photoBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *questionTextField;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UITextView *detailQTView;
@property (nonatomic,strong)UIImagePickerController *imagePicker;

@property (nonatomic,strong)UIWindow *window;

@end

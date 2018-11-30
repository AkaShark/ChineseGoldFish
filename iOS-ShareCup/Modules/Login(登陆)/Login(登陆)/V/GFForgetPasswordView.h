//
//  GFForgetPasswordView.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/25.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFForgetPasswordView : UIView
@property (nonatomic,strong)UITextField *phoneNumTextField;
@property (nonatomic,strong)UITextField *numTextField;
@property (nonatomic,strong)UITextField *PswTextField;
@property (nonatomic,strong)UIButton *sendNumBtn;
@property (nonatomic,strong)UIView *phoneNumView;
@property (nonatomic,strong)UIView *numView;
@property (nonatomic,strong)UIView *PswView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)int count;
- (void)setUpTheUI;
@end

NS_ASSUME_NONNULL_END

//
//  GFLoginView.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/23.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^userLogin)(void);
typedef void(^regCallBack)(void);
@interface GFLoginView : UIView
@property (nonatomic,strong)UIImageView *mainImageView;
@property (nonatomic,strong)UIImageView *userImageView;
@property (nonatomic,strong)UIImageView *pswImageView;
@property (nonatomic,strong)UITextField *userTextField;
@property (nonatomic,strong)UITextField *pswTextField;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *eyeBtn;
@property (nonatomic,strong)UIView *userView;
@property (nonatomic,strong)UIView *pswView;

@property (nonatomic,copy) userLogin loginCallBack;

@property (nonatomic,copy) regCallBack regCallback;

- (void)setUpTheUI;
@end

NS_ASSUME_NONNULL_END

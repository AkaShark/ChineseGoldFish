//
//  GFRegisterView.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/21.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^backToLogin)(void);

@interface GFRegisterView : UIView<MBProgressHUDDelegate>
@property (nonatomic,strong)UIImageView *mainImageView;
@property (nonatomic,strong)UIImageView *userImageView;
@property (nonatomic,strong)UIImageView *securityImageView;
@property (nonatomic,strong)UIImageView *pswImageView;
@property (nonatomic,strong)UITextField *userTextField;
@property (nonatomic,strong)UITextField *securityTextField;
@property (nonatomic,strong)UITextField *pswTextField;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,strong)UIButton *gainBtn;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIView *userView;
@property (nonatomic,strong)UIView *securityView;
@property (nonatomic,strong)UIView *pswView;
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,copy) backToLogin logincallBack;


@property (nonatomic,strong)MBProgressHUD *HUD;

- (void)setUpTheUI;

@end

NS_ASSUME_NONNULL_END

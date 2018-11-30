//
//  GFMyNotesViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/23.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFMyNotesViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface GFMyNotesViewController ()

@property (nonatomic,strong) UITextView *textView;


@end

@implementation GFMyNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSString translation:@"我的鱼文" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _textView.editable = NO;
    
    _textView.selectable = YES;
    
    _textView.font = [UIFont fontWithName:@"GillSans" size:20.0];
    _textView.text = _str;
    
    [self.view addSubview:_textView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareTitle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

// 分享事件
- (void)shareTitle
{
    NSArray* imageArray = @[[UIImage imageNamed:@"金鱼0"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.str
                                         images:imageArray
                                            url:[NSURL URLWithString:@"www.baidu.com"]
                                          title:@"鱼文日志"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
    }
}



@end

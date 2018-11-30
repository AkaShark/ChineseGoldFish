//
//  GFTabBarCentButton.m
//  iOS-ShareCup
//
//  Created by kys-20 on 10/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFTabBarCentButton.h"
#import "MMDrawerController.h"
#import "BHBPopView.h"
#import "GFSendFishArticleViewController.h"
#import "GFTakeFishPhotoViewController.h"
#import "GFAnswerAndQuestionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GFLoginViewController.h"
#import "AppDelegate.h"
@interface GFTabBarCentButton ()<UIImagePickerControllerDelegate,UINavigationBarDelegate> {
    CGFloat _buttonImageHeight;
}

@end
@implementation GFTabBarCentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

// 创建中间按钮 特殊按钮
+ (id)plusButton
{
    
    UIImage *buttonImage = [UIImage imageNamed:@"tabbar_compose_button"];
    UIImage *highlightImage = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
    UIImage *iconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];
    UIImage *highlightIconImage = [UIImage imageNamed:@"tabbar_compose_icon_add"];

    GFTabBarCentButton *button = [GFTabBarCentButton buttonWithType:UIButtonTypeCustom];

    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:highlightIconImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)clickPublish
{
    
    //    判断是否登录
    NSDictionary *dic = [[UserManager defaultManager] getUserDict];
    if ([dic[@"isLogin"] isEqualToString:@"1"])
    {
        NSLog(@"登陆了可以看的");
        
    }
    else
    {
        NSLog(@"没登录 不让看哦");
        GFLoginViewController *loginVc = [GFLoginViewController new];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabBarController setSelectedIndex:0];
    [appDelegate.tabBarController.selectedViewController presentViewController:loginVc animated:YES completion:nil];
        return;
    }
    
    
    MMDrawerController *drawer = (MMDrawerController *)self.window.rootViewController;
    UITabBarController *tabBarController = (UITabBarController *)drawer.centerViewController;
    UINavigationController *viewControllerNav = tabBarController.selectedViewController;
    
    
     BHBItem * item3 = [[BHBItem alloc]initWithTitle:@"" Icon:@""];
     BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"" Icon:@""];
     BHBItem * item5 = [[BHBItem alloc]initWithTitle:@"" Icon:@""];
    
    
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"鱼文" Icon:@"images.bundle/tabbar_compose_idea"];

    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"鱼拍" Icon:@"images.bundle/tabbar_compose_wbcamera"];
   
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"鱼问" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    
//    BHBItem * item3 = [[BHBItem alloc]initWithTitle:@"相册" Icon:@"images.bundle/tabbar_compose_review"];
//
//    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"日志" Icon:@"images.bundle/tabbar_compose_review"];
//
//    BHBItem * item5 = [[BHBItem alloc]initWithTitle:@"签到" Icon:@"images.bundle/tabbar_compose_review"];
    
    //添加popview
    [BHBPopView showToView:viewControllerNav.view.window withItems:@[item3,item4,item5,item0,item1,item2]andSelectBlock:^(BHBItem *item) {
        
        if ([item.title  isEqual: @"鱼文"]) {
            GFSendFishArticleViewController *sendFA = [[GFSendFishArticleViewController alloc]init];
            
            [self.viewController presentViewController:sendFA animated:YES completion:nil];
            
        }
        if ([item.title  isEqual: @"鱼拍"]) {
            
            self->_Picker = [[UIImagePickerController alloc]init];
            
            self->_Picker.delegate = self;
           
            self->_Picker.sourceType = UIImagePickerControllerSourceTypeCamera;

            //设置拍摄照片
            self->_Picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            //设置使用手机的后置摄像头（默认使用后置摄像头）
            self->_Picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            //设置拍摄的照片允许编辑
            self->_Picker.allowsEditing = YES;
            
//            [self.viewController.view addSubview:self->_Picker];
//            GFTakeFishPhotoViewController *photo = [[GFTakeFishPhotoViewController alloc]init];
//
            [self.viewController presentViewController:self->_Picker animated:YES completion:nil];
//            [self.viewController.navigationController pushViewController:photo animated:YES];
            
        }if ([item.title isEqual: @"鱼问"]) {
            GFAnswerAndQuestionViewController *answerVC = [[GFAnswerAndQuestionViewController alloc]init];
            
            [self.viewController presentViewController:answerVC animated:YES completion:nil];
        }
    
    }];
    
}


//拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
//    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]&&picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *theImage = nil;
        if ([picker allowsEditing]) {
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil);
//    }
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}



@end




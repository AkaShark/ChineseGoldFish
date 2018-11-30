//
//  GFCameraHandler.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFCameraHandler.h"
#import <AVFoundation/AVFoundation.h>

@interface GFCameraHandler()<UINavigationControllerDelegate,LSHImagePickerControllerDelegate>

@property (nonatomic,assign) BOOL cameraShowed;

@property (nonatomic, weak) UIViewController *viewcontroller;

@property (nonatomic, copy) CameraFinishBlock finishBlock;

@property (nonatomic,copy) void(^cancelBlock)(void);

@property (nonatomic,strong) HUDTA *hud;

@end

@implementation GFCameraHandler


+ (instancetype)shareHandler
{
    static dispatch_once_t onceToken;
    static GFCameraHandler *handler;
    dispatch_once(&onceToken, ^{
        handler = [[GFCameraHandler alloc] init];
    });
    handler.cameraShowed = NO;
    
    return handler;
}


- (void)showCameraPickerInController:(UIViewController *)viewController finishBlock:(CameraFinishBlock)block
{
       [self showCameraPickerInController:viewController finishBlock:block cancelBlock:nil];
}

- (void)showCameraPickerInController:(UIViewController*)viewcontroller finishBlock:(CameraFinishBlock)block cancelBlock:(void (^)(void))cancelBlock
{
    self.cameraShowed = YES;
    self.viewcontroller = viewcontroller;
    
    self.finishBlock = block;
    self.cancelBlock = cancelBlock;
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
//      弹出警告框
        
    }
    if (![self cameraAuthorized])
    {
        return;
    }
    
    GFImagePickerViewController *picker = [[GFImagePickerViewController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    
    [self.viewcontroller presentViewController:[[UINavigationController alloc] initWithRootViewController:picker] animated:YES completion:nil];
    
    
}

- (BOOL)cameraAuthorized
{
    if ([UIDevice currentDevice].systemVersion.floatValue >=7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
//            弹出警告框
            return NO;
            
        }
    }
    return YES;
}


#pragma  mark - LSHImagePickerController Delegate

- (void)imagePickerControllerUseImage:(LSHImagePickerViewController *)picker Image:(UIImage *)image
{
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    view.backgroundColor = [UIColor blackColor];
//    view.tag = 1209;
//    [[UIApplication sharedApplication].delegate.window addSubview:view];
    
    @weakify(self);
    _hud = [HUDTA new];
    [NSString translation:@"正在识别"
              CallbackStr:^(NSString * _Nonnull str) {
                  [weak_self.hud showScreenHudWithStr:str AndOption:TAOverlayOptionOverlaySizeFullScreen];
              }];
//   [_hud showScreenHudWithStr:@"正在识别" AndOption:TAOverlayOptionOverlaySizeFullScreen];
    
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        修复图片的朝向
    if (self.finishBlock)
    {
        self.finishBlock(image);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [picker dismissViewControllerAnimated:NO completion:^{
            [self performSelector:@selector(showCameraWithView:) withObject:nil afterDelay:0.2f];
        }];
    });
});

}

- (void)imagePickerControllerDidCancel:(LSHImagePickerViewController *)picker
{
    if (self.cancelBlock)
    {
        self.cancelBlock();
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerRetakePhoto:(LSHImagePickerViewController *)picker{
    
}

- (void)imagePickerControllerTakePhoto:(LSHImagePickerViewController *)picker
{
    
}

//继续拍照换了个黑色的遮盖上0.2秒保证其他操作
- (void)showCameraWithView: (UIView *)view
{
 
    
    GFImagePickerViewController *newPicker = [[GFImagePickerViewController alloc] init];
    newPicker.delegate = self;
    //newPicker.allowsEditing = NO;
    newPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.viewcontroller presentViewController:[[UINavigationController alloc] initWithRootViewController:newPicker] animated:NO completion:^{
       
    }];
    
    
//    接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenHud) name:@"hiddenHud" object:nil];
    
    
}
//隐藏方法
- (void)hiddenHud
{
    [_hud hiddenHud];
}

- (void)dealloc
{
      [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hiddenHud" object:nil];
}


@end

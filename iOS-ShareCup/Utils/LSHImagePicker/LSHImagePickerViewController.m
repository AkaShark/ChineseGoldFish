//
//  LSHImagePickerViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/3.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "LSHImagePickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LSHImagePickerViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) LSHimagePickOverLayView *overlayView;

@property (nonatomic) dispatch_queue_t sessionQueue;

@property (nonatomic,strong) AVCaptureSession *seesion;

@property (nonatomic,strong) AVCaptureDeviceInput *videoInput;

@property (nonatomic,strong) AVCaptureStillImageOutput *imageOutput;

@property (nonatomic,strong) AVCaptureDevice *device;

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic,strong) NSData *imageData;

@property (nonatomic,assign) CGFloat beginGestureScale;

@property (nonatomic,assign) CGFloat effectiveScale;

@end

@implementation LSHImagePickerViewController

#pragma mark -lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self takePhotoViewConfig];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.seesion)
    {
        [self.seesion startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.seesion)
    {
        [self.seesion stopRunning];
    }
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma Private Method

- (void)takePhotoViewConfig
{
    [self takePhoto_initAVCaptureSession];
    [self takePhoto_configGesture];
    [self takePhoto_configActions];
    
    self.effectiveScale = self.beginGestureScale = 1.0f;
    
}

- (void)takePhoto_initAVCaptureSession
{
    self.seesion = [[AVCaptureSession alloc] init];
    [self.seesion setSessionPreset:AVCaptureSessionPresetPhoto];
    
    NSError *error;
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:outputSettings];
    
    if ([self.seesion canAddInput:self.videoInput])
    {
        [self.seesion addInput:self.videoInput];
    }
    if ([self.seesion canAddOutput:self.imageOutput])
    {
        [self.seesion  addOutput:self.imageOutput];
    }
    
    
//    初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.seesion];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    self.previewLayer.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.preview = [[LSHimagePickOverLayView alloc] init];
    self.preview.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    
    [self.preview layoutSubviews];
    [self.preview.layer addSublayer:self.previewLayer];
    [self.view addSubview:self.preview];
    
//    添加顶部底部自定义工具
//    [self.view addSubview:self.preview.topbar];
    [self.view addSubview:self.preview.buttomBar];
//    self.preview.topbar.frame = CGRectMake(0, 0, self.view.width, 64 * KScreenWidth/320.0);
    self.preview.buttomBar.frame = CGRectMake(0, self.view.height - 70 * KScreenWidth/320.0 , self.view.width, 70* KScreenWidth/320.0);
    [self.preview layoutSubviews];
    
    
//    设置拍照后预览图层
    self.preImageView = [[LSHImagePickPreImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.preImageView layoutSubviews];
    self.preImageView.hidden = YES;
    [self.view addSubview:self.preImageView];
}

- (void)takePhoto_configGesture
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self.preview addGestureRecognizer:pinch];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusAction:)];
    [self.preview addGestureRecognizer:tap];
    
}

- (void)takePhoto_configActions
{
    [self.preview.tabkePictureBtn addTarget:self action:@selector(takePhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.preview.cancelButton addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.preImageView.reTakeButton addTarget:self action:@selector(retakeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.preImageView.useImageButton addTarget:self action:@selector(useImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions
//里面的很多属性没看明白
- (void)focusAction:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.preview];
    CGPoint pointInsect = CGPointMake(location.x/self.view.width, location.y/self.view.height);
    
    [self.preview.focusView setCenter:location];
    self.preview.focusView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.preview.focusView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.preview.focusView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.preview.focusView.hidden = YES;
        }];
    }];
    
    if ([self.device isFocusPointOfInterestSupported] && [self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
    {
        NSError *error;
        if ([self.device lockForConfiguration:&error])
        {
            if ([self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
            {
                [self.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
//                ？？？
                [self.device setFocusPointOfInterest:pointInsect];
            }
            
            if ([self.device isExposurePointOfInterestSupported] && [self.device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
            {
                [self.device setExposurePointOfInterest:pointInsect];
                [self.device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            }
            
            [self.device unlockForConfiguration];
        }
        
    }
    
    
}

- (void)takePhotoBtnClick:(id)sender
{
    AVCaptureConnection *stillImageConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [stillImageConnection setVideoScaleAndCropFactor:self.effectiveScale];
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.imageData = jpegData;
        CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, imageDataSampleBuffer, kCMAttachmentMode_ShouldPropagate);
        
        UIImage *image = [UIImage imageWithData:jpegData];
        self.preImageView.imageView.image = image;
        [self.preview hiddenSelfAndBar:YES];
        self.preImageView.hidden = NO;
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
            
        {
//            无权限
            return ;
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerTakePhoto:)])
    {
        [self.delegate imagePickerControllerTakePhoto:self];
    }
    
}

- (void)cancelBtnClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)])
    {
        [self.delegate imagePickerControllerDidCancel:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)retakeBtnClick:(id)sender{
    [self.preview hiddenSelfAndBar:NO];
    self.preImageView.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerRetakePhoto:)])
    {
        [self.delegate imagePickerControllerRetakePhoto:self];
    }
    
}


- (void)useImageBtnClick:(id)sender
{
    [self.preview hiddenSelfAndBar:NO];
    self.preImageView.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerUseImage:Image:)]) {
        [self.delegate imagePickerControllerUseImage:self Image:[UIImage imageWithData:self.imageData]];
    }

}

//滑动手势 对于手势的理解差不多但是对于属性的理解太少了看不懂啊
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)reconginzer
{
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [reconginzer numberOfTouches], i;
    for (i=0; i<numTouches; i++)
    {
        CGPoint location = [reconginzer locationOfTouch:i inView:self.preview];
        CGPoint convertedLocation = [self.previewLayer convertPoint:location fromLayer:self.previewLayer.superlayer];
        if (![self.previewLayer containsPoint:convertedLocation])
        {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
        
    }
    
    if (allTouchesAreOnThePreviewLayer)
    {
        self.effectiveScale = self.beginGestureScale *reconginzer.scale;
        if (self.effectiveScale < 1.0)
        {
            self.effectiveScale = 1.0;
        }
        CGFloat maxScaleAndCropFactor = [[self.imageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        if (self.effectiveScale > maxScaleAndCropFactor)
        {
            self.effectiveScale = maxScaleAndCropFactor;
        }
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(self.effectiveScale, self.effectiveScale)];
        [CATransaction commit];
        
    }
    
}

# pragma mark -gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}






@end

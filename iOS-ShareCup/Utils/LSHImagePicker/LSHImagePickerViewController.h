//
//  LSHImagePickerViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/3.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSHimagePickOverLayView.h"
#import "LSHImagePickPreImageView.h"


NS_ASSUME_NONNULL_BEGIN

@class LSHImagePickerViewController;
@protocol LSHImagePickerControllerDelegate <NSObject>


/**
 如函数名所示
 @param picker pciker
 */
- (void)imagePickerControllerTakePhoto:(LSHImagePickerViewController *)picker;

- (void)imagePickerControllerDidCancel:(LSHImagePickerViewController *)picker;

- (void)imagePickerControllerRetakePhoto:(LSHImagePickerViewController *)picker;

- (void)imagePickerControllerUseImage:(LSHImagePickerViewController *)picker Image:(UIImage *)image;

@end

@interface LSHImagePickerViewController : UIViewController

@property (nonatomic,weak) id<LSHImagePickerControllerDelegate> delegate;

@property (nonatomic,assign) UIImagePickerControllerSourceType sourceType;

@property (nonatomic,strong) LSHimagePickOverLayView *preview;

@property (nonatomic,strong) LSHImagePickPreImageView *preImageView;

- (void)takePhotoViewConfig;

- (void)takePhotoBtnClick:(id)sender;
- (void)cancelBtnClick:(id)sender;
- (void)retakeBtnClick:(id)sender;
- (void)useImageBtnClick:(id)sender;


@end

NS_ASSUME_NONNULL_END

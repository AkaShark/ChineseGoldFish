//
//  GFCameraHandler.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFImagePickerViewController.h"

//NS_ASSUME_NONNULL_BEGIN

typedef void(^CameraFinishBlock)(UIImage *originImage);


/**
 关于这个拍照功能的实现 这几天状态不是很好写的很垃圾 不优雅
 */
@interface GFCameraHandler : NSObject



+ (instancetype)shareHandler;


// this block is run in global queue, not the main queue
- (void)showCameraPickerInController:(UIViewController *)viewController finishBlock:(CameraFinishBlock)block;

- (void)showCameraPickerInController:(UIViewController*)viewcontroller finishBlock:(CameraFinishBlock)block cancelBlock:(void (^)(void))cancelBlock;




@end

//NS_ASSUME_NONNULL_END

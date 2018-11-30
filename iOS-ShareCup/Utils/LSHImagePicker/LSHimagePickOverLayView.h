//
//  GFimagePickOverLayView.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/3.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSHimagePickOverLayView : UIView

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *tabkePictureBtn;
@property (nonatomic, strong) UIImageView *imageLibView;
@property (nonatomic, strong) UIView *buttomBar;

@property (nonatomic, strong) UIImageView *focusView;


//@property (nonatomic,strong) UIView *topbar;

//关闭界面

//- (void)resetTopBar;

- (void)hiddenSelfAndBar:(BOOL)hidden;


@end

NS_ASSUME_NONNULL_END

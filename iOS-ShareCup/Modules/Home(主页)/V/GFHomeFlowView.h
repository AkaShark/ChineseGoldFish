//
//  GFHomeFlowView.h
//  HQCardFlowView
//
//  Created by kys-20 on 10/09/2018.
//  Copyright © 2018 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HQFlowView.h"
#import "HQImagePageControl.h"

@interface GFHomeFlowView : UIView<HQFlowViewDelegate,HQFlowViewDataSource>

@property (nonatomic,strong) UIImage *backImage;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *advArray;
/**
 *  轮播图
 */
@property (nonatomic, strong) HQImagePageControl *pageC;
@property (nonatomic, strong) HQFlowView *pageFlowView;
@property (nonatomic, strong) UIScrollView *scrollView; // 轮播图容器
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) HQIndexBannerSubview*bannerView;


@end

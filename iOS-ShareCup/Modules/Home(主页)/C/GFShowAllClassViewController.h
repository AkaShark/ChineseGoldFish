//
//  GFShowAllClassViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFShowAllClassViewController : glodFishBaseViewController


@property (nonatomic,strong) UIImageView *headImgView;
// 图片url
@property (nonatomic,copy) NSString *imageURl;
// 种类名字
@property (nonatomic,strong) NSString *varityName;


@end

NS_ASSUME_NONNULL_END

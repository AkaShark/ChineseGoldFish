//
//  GFShowClassDetailViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

@class GFShowDetailModel;
/**
 具体展示界面
 */
@interface GFShowClassDetailViewController : glodFishBaseViewController

@property (nonatomic,strong) GFShowDetailModel *model;

@property (nonatomic,assign) BOOL isTransitrion; //是否开启转场动画

// 种类（four many）
@property (nonatomic,copy) NSString *type;



@end

//
//  GFLoginViewController.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/23.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"
#import "GFLoginView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GFLoginViewController : glodFishBaseViewController

@property (nonatomic,strong)GFLoginView *loginView;

@property (nonatomic,strong) NSString *nickName;

@property (nonatomic,strong) NSString *signature;

@property (nonatomic,strong) NSString *area;

@end

NS_ASSUME_NONNULL_END

//
//  GFInformationChangeViewController.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/10/17.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFInformationChangeViewController : glodFishBaseViewController

@property (nonatomic,strong)UITextField *changeTextField;

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)UILabel *detailLabel;

@property (nonatomic,copy) NSString *labelStr;

@property (nonatomic,copy) void(^passValueBlock)(NSString * cellDetailText);
@end

NS_ASSUME_NONNULL_END

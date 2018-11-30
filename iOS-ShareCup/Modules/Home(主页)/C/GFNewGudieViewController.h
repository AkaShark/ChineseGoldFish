//
//  GFNewGudieViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/21.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^touchTheGuide)(void);

@interface GFNewGudieViewController : UIViewController

@property (nonatomic,copy) touchTheGuide callBack;


@end

NS_ASSUME_NONNULL_END

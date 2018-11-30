//
//  GFSideWaterView.h
//  iOS-ShareCup
//
//  Created by kys-20 on 09/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClick)(NSInteger tag);

@interface GFSideWaterView : UIView

@property (nonatomic,copy) BtnClick callBack;

- (void)setWave;


@end

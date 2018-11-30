//
//  StartBtn.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataModel.h"

@interface StartBtn : UIButton

- (instancetype)initWithFrame:(CGRect)frame withDataModel:(CellDataModel *)dataModel;
//是否选中
- (void)setSelected:(BOOL)selected;


@end

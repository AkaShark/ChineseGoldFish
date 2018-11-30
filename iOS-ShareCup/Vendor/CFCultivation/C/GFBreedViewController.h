//
//  GFBreedViewController.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/17.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"
#import "YSLDraggableCardContainer.h"


@interface GFBreedViewController : glodFishBaseViewController

@property (nonatomic,strong)YSLDraggableCardContainer *container;

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic,strong) NSArray * imageArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *urlArray;

@end

//
//  GFRecongitionViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"
#import "GFRecognitionTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFRecongitionViewController : glodFishBaseViewController

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) NSMutableArray *scoreArray;
@property (nonatomic,strong) NSMutableArray *urlArray;


@end

NS_ASSUME_NONNULL_END

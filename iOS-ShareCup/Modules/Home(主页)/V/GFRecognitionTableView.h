//
//  GFRecognitionTableView.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^closeTheView)(void);
typedef void(^CallBack)(NSInteger index);

@interface GFRecognitionTableView : UITableView

@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic,copy) NSArray *detailArray;

//@property (nonatomic,copy) NSArray *urlArray;

@property (nonatomic,copy) closeTheView callBack;

@property (nonatomic,copy) CallBack pushView;

@end

NS_ASSUME_NONNULL_END

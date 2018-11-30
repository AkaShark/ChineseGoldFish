//
//  GFPersonalInformationViewController.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/10/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "glodFishBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFPersonalInformationViewController : glodFishBaseViewController

@property (nonatomic ,strong)NSArray *inforArray;

@property (nonatomic,strong)NSArray *detailLabelArray;

@property (nonatomic,strong)NSMutableArray *detailTextArray;

@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property (nonatomic,strong)UITableView *personInforTableView;

@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,strong)NSMutableDictionary *changeDict;
@property (nonatomic,strong)NSString *cell1Str;

@property (nonatomic,strong)NSString *cell2Str;

@property (nonatomic,strong)NSString *cell3Str;

@end

NS_ASSUME_NONNULL_END

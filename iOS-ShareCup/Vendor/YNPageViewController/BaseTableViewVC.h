//
//  BaseVC.h
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFHomeBottomTableViewCell.h"
#import "GFNewsModel.h"

@interface BaseTableViewVC : UIViewController

@property (nonatomic, copy) NSString *cellTitle;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *modelArray;


@end

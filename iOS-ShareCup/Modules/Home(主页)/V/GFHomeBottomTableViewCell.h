//
//  GFHomeBottomTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 12/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFHomeBottomTableViewCell : UITableViewCell

// 图片数组
@property (nonatomic,copy) NSString *imageName;

// 标题
@property (nonatomic,copy) NSString *titleStr;

- (void)upDataTheData:(NSString *)imageName title:(NSString *)titleStr andDetail:(NSString *)detail;


@end

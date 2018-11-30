//
//  GFMyCollectionTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/11/13.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFMyCollectionTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *mainImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

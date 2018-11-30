//
//  GFShowDocumentTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/14.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFShowDocumentTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *titleString;
- (void)setUIDataTitleStr :(NSString *)str andImageStr: (NSString *)imageStr;
@end

NS_ASSUME_NONNULL_END

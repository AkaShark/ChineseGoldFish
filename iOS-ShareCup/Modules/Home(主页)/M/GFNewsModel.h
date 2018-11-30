//
//  GFNewsModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/10.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GFNewsModel : NSObject

@property (nonatomic,copy) NSString *contentURl;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *detailStr;

@end

NS_ASSUME_NONNULL_END

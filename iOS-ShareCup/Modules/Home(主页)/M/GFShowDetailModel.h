//
//  GFShowDetailModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFShowDetailModel : NSObject <NSCoding>
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *detailStr;
@end

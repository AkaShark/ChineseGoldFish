//
//  goldFishBaseCellModel.h
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 具体根据cell的样子决定数据类型
 */
@interface goldFishBaseCellModel : NSObject

@property (nonatomic,copy) NSString *className;

@property (nonatomic,copy) NSString *name;

//@property (nonatomic,copy) NSString *

@property (nonatomic,assign) CGFloat cellHeight;

@end

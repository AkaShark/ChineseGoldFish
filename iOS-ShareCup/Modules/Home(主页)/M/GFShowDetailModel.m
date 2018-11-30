//
//  GFShowDetailModel.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDetailModel.h"

@implementation GFShowDetailModel

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.className forKey:@"className"];
    [aCoder encodeObject:self.detailStr forKey:@"detailStr"];
}

//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.className = [aDecoder decodeObjectForKey:@"className"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.detailStr = [aDecoder decodeObjectForKey:@"detailStr"];
    }
    
    return self;
}


@end

//
//  GFShowClassLogic.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/15.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowClassLogic.h"
#import "GFShowClassModel.h"
#import "GFShowDetailModel.h"
#import "MJExtension.h"
@interface GFShowClassLogic()

@end

@implementation GFShowClassLogic

- (instancetype)init
{
    if (self = [super init])
    {
        self.type = @"manyClass";
    }
    return self;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
//请求数据
- (void)requestData
{
//    代码冗余了 将请求的方法抽箱出来 值传递参数
//    判断类型
    NSString *url = [[NSString alloc]init];
    if ([self.type isEqualToString:@"All"])
    {
        
        url =  [NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFishAll.php?all=1"];
    }
    else
    {
        url = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFish.php?howMany=%@&tableName=%@",_type,_type];
    }
    
//    请求数据
    [self.dataArray removeAllObjects];
    [POST_GET GET:url parameters:nil succeed:^(id responseObject) {
        GFShowClassModel *model = [GFShowClassModel mj_objectWithKeyValues:responseObject[@"result"]];
        for (int i =0; i<model.ClassName.count; i++)
        {
            if(![model.image[i] isEqualToString:@""])
            {
                GFShowDetailModel *data = [GFShowDetailModel new];
                data.imageUrl = model.image[i];
                data.className = model.ClassName[i];
                data.detailStr = model.classDetail[i];
                [self.dataArray addObject:data];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataCompleted)])
            {
                [self.delegate requestDataCompleted];
            }
        });
    } failure:^(NSError *error) {
        
    }];
    
}
@end

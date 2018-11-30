//
//  GFShowDetailLogic.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/2.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowDetailLogic.h"

@implementation GFShowDetailLogic

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}
//请求数据
- (void)requestData
{
    NSString *tableName;
    if ([_type isEqualToString:@"manyClass"])
    {
        tableName = @"manyVariety";
    }
    else
    {
        tableName = @"fourVariey";
    }
    NSString *url = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFishSelect.php?howMany=%@&tableName=%@&variety=%@",_type,tableName,_className];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [POST_GET GET:url parameters:nil succeed:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *array = (NSArray *)((NSDictionary *)responseObject[@"result"][@"class"]);
        
        for (int i=0;i<array.count;i++)
        {
            GFShowVarietyModel *model = [[GFShowVarietyModel alloc] init];
//            设置数据
            [NSString translation:array[i][3] CallbackStr:^(NSString * _Nonnull str) {
                model.detailStr = str;
                model.imageURl = array[i][4];
                model.varietyName = array[i][2];
                [self.modelArray addObject:model];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSNotification *dataComplicetion = [NSNotification notificationWithName:@"dataComplicetion" object:self.modelArray];
                    [[NSNotificationCenter defaultCenter] postNotification:dataComplicetion];
                });
            }];   
        }
    } failure:^(NSError *error) {
        
    }];
}

@end


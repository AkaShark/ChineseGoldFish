//
//  AppDelegate+IMService.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "AppDelegate+IMService.h"
#import <RongIMKit/RongIMKit.h>

@implementation AppDelegate (IMService)


- (void)IMServiceInit
{
    [[RCIM sharedRCIM] initWithAppKey:@"tdrvipkstxbk5"];
    
}

@end

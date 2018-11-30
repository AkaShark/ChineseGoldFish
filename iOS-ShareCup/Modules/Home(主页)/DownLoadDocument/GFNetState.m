//
//  GFNetState.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFNetState.h"

@implementation GFNetState

- (void)netOfState:(void(^)(int type))stateType
{
    // 监测网络情况
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                stateType(0);
                //没有网络
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //使用的数据流量
                stateType(1);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //使用WiFi
                stateType(2);
                break;
                
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end

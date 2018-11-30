//
//  CALeftWeatherView.h
//  CamelliaApp
//
//  Created by kys-20 on 2017/11/3.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALeftWeatherViewVIew.h"
@interface CALeftWeatherView : UIView
@property (nonatomic,strong) CALeftWeatherViewVIew *weatherView;
- (void)createLocationManager;
@end

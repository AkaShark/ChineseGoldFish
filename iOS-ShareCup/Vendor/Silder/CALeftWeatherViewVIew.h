//
//  CALeftWeatherViewVIew.h
//  CamelliaApp
//
//  Created by kys-20 on 2017/11/3.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@interface CALeftWeatherViewVIew : UIView
@property (nonatomic,strong)WeatherModel *model;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *temperatureLable;
@property (nonatomic,strong) UILabel *locationLable;
@property (nonatomic,strong) UILabel *topLable;
@property (nonatomic,strong) UILabel *wetLable;
@end

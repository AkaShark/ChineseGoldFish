//
//  fontAndColorMacros.h
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#ifndef fontAndColorMacros_h
#define fontAndColorMacros_h

#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区

#define RGB(r,g,b,a) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:a]


//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"0d9fff"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]
// 主颜色调
#define StandColor [UIColor colorWithHexString:@"eeedec"];
#define StandBackColor [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:0.5]
//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]

//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]


#pragma mark -  字体区


#define FFont1 [UIFont systemFontOfSize:12.0f]




#endif /* fontAndColorMacros_h */

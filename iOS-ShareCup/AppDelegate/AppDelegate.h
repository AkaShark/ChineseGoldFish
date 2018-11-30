//
//  AppDelegate.h
//  iOS-ShareCup
//
//  Created by kys-20 on 05/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"

static BOOL showAssistantPoint  = NO;   //显示辅助点
static BOOL showPath            = NO;   //显示路径
static BOOL showPathBgViewColor = NO;   //显示路径层的背景色
static BOOL flowViewClipBounds  = YES;  //主view clipBounds
static BOOL needDragGesture     = NO;   //是否需要拖动手势
static BOOL showSingleFlowDemo  = YES;  //只显示一个demo view

@class MMDrawerController;

/**
 只去调用方法不做实现，实现都放在分类中
 注意点：
 * 1. 类名小写的类为基类如果需要用到的话去集成（但是类名是要大写的！！)
 * 2. 写给自己（宏定义的文件写错了。。类名要大写）时间关系（给自己找的接口 懒得现在改了后来再改 review ！！！）
 * 3.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate,CYLTabBarControllerDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
// 侧滑
@property (nonatomic,strong) MMDrawerController *drawerController;
// 导航栏控制器
@property (nonatomic,strong) CYLTabBarController *tabBarController;

@end



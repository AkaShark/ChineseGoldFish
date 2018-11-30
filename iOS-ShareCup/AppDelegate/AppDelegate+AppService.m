//
//  AppDelegate+AppService.m
//  iOS-ShareCup
//
//  Created by kys-20 on 07/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//
/*
 1.遇到一个问题在设置侧滑的时候将侧滑的属性写在了AppDelegate的分类里面报错了 说：
 ```
 Property 'drawerController' requires method 'drawerController' to be defined - use @dynamic or provide a method implementation in this category
 ```
 感觉是对应分类理解的不到位
 */

#import "AppDelegate+AppService.h"

//侧滑
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
// 侧滑出来的控制器
#import "GFSildViewController.h"

//tabbar控制器
#import "GFHomeViewController.h"
#import "GFSocialViewController.h"
#import "GFMeViewController.h"

//CYLTabBar
#import "CYLTabBarController.h"
#import "GFTabBarCentButton.h"
#import "CYLTabBarControllerConfig.h"

// 导入系统框架
#import <AudioToolbox/AudioToolbox.h>

//登陆注册界面
#import "GFLoginViewController.h"

//引导页
#import "GFGuideViewController.h"

@implementation AppDelegate (AppService)


- (void)initRootController
{
    BOOL isGudied = [[NSUserDefaults standardUserDefaults] boolForKey:@"guided"];
    if (!isGudied)
    {
        GFGuideViewController *guideVC = [[GFGuideViewController alloc] init];
        guideVC.showLaunchAnimation = YES;
        [self.window setRootViewController:guideVC];
    }
    else
    {
        //    注册
        [GFTabBarCentButton registerPlusButton];
        
        //    [self setUpViewControllers];
        //    侧滑界面
        GFSildViewController *sild = [[GFSildViewController alloc] init];
        CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
        self.tabBarController  = tabBarControllerConfig.tabBarController;
        /// 使用MMDrawerController
        self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:self.tabBarController leftDrawerViewController:sild];
        self.tabBarController.delegate = self;
        //    设置阴影
        [self.drawerController setShowsShadow:YES];
        
        [self.drawerController setMaximumLeftDrawerWidth:200.0f];
        ////    设置打开关闭手势
        self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
        self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        
        //    设置左右抽箱显示的多少
        self.drawerController.maximumLeftDrawerWidth = KScreenWidth-100;
        
        //    初始化窗口 根控制器 显示窗口
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setRootViewController:self.drawerController];
        [self.window makeKeyAndVisible];
    }
    

}

// 点击tabbar的点击事件
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control
{
//    点击播放音效
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:@"tapSound" ofType:@"wav"];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
//    获得系统声音ID
    SystemSoundID soundID = 0;
//    infileUrl 声音文件URl outSystemSoundId 声音ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
//    播放
    AudioServicesPlaySystemSound(soundID);
//    AudioServicesPlayAlertSound(soundID);
     AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    if (self.tabBarController.selectedIndex == 3 || self.tabBarController.selectedIndex == 2)
    {
        NSDictionary *dic = [[UserManager defaultManager] getUserDict];
        if ([dic[@"isLogin"] isEqualToString:@"1"])
        {
             NSLog(@"登陆了可以看的");
            
        }
        else
        {
            NSLog(@"没登录 不让看哦");
            GFLoginViewController *loginVc = [GFLoginViewController new];
            [self.tabBarController setSelectedIndex:0];
            [tabBarController.selectedViewController presentViewController:loginVc animated:YES completion:nil];
        }
    }
    
    
}



void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    //  销毁
    AudioServicesDisposeSystemSoundID(soundID);
    NSLog(@"播放完成");
}

@end

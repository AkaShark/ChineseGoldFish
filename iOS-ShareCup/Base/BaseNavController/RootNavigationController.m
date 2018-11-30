//
//  RootNavigationController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "RootNavigationController.h"
#import "glodFishBaseViewController.h"
@interface RootNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id popDelegate;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *popRecognizer;


@end

@implementation RootNavigationController

//APP生命周期中 只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];//去掉阴影线
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
//    self.delegate = self;

//    self.interactivePopGestureRecognizer.delegate = self;
    //默认关闭系统右划返回
self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    //只有在使用转场动画时，禁用系统手势，开启自定义右划手势
//    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
//    //下面是全屏返回
//    //        _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
//    _popRecognizer.edges = UIRectEdgeLeft;
//    [_popRecognizer setEnabled:NO];
//    [self.view addGestureRecognizer:_popRecognizer];
}
////解决手势失效问题
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (_isSystemSlidBack) {
//        self.interactivePopGestureRecognizer.enabled = YES;
//        [_popRecognizer setEnabled:NO];
//    }else{
//        self.interactivePopGestureRecognizer.enabled = NO;
//        [_popRecognizer setEnabled:YES];
//    }
//}

//根视图禁用右划返回
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return self.childViewControllers.count == 1 ? NO : YES;
//}

//push时隐藏tabbar
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) {
//       viewController.hidesBottomBarWhenPushed = YES;
//        
//    }
//    [super pushViewController:viewController animated:animated];
//    // 修改tabBra的frame
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
//}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[glodFishBaseViewController class]]) {
        glodFishBaseViewController * vc = (glodFishBaseViewController *)viewController;
//       设置导航栏隐藏
        if (vc.isHidenNaviBar) {
            vc.view.top = 0; //改变高度 OK
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
    
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    
    return nil;
}


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

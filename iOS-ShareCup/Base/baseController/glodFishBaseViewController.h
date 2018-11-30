//
//  glodFishBaseViewController.h
//  iOS-ShareCup
//
//  Created by kys-20 on 08/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "UIViewController+AlertViewAndActionSheet.h"
/**
 封装基类VC
 */
@interface glodFishBaseViewController : UIViewController
//修改状态栏颜色
@property (nonatomic,assign) UIStatusBarStyle StatusbarStyle;
//table
@property (nonatomic,strong) UITableView *tableView;
//collection
@property (nonatomic,strong) UICollectionView *collectionView;


/**
 显示没有数据页面
 */
- (void)showNoDataImage;

/**
 移除没有数据界面
 */
- (void)removeDataImage;

/**
 Loading
 */
- (void)showLoadingAnimation;

/**
 停止loading
 */
- (void)stopLoadingAnimation;

/**
 是否显示返回按钮 默认为yes
 */
@property (nonatomic,assign) BOOL isShowLiftBack;
/**
 是否隐藏导航栏
 */
@property (nonatomic,assign) BOOL isHidenNaviBar;


/**
 导航栏添加文本标题

 @param titles 标题文本数组
 @param isLeft 是否在左边
 @param target 目标
 @param action 事件
 @param tags tags区分回调
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮
 
 @param imageNames 图片名称数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;



/**
 点击回调 默认是返回，子类重写
 */
- (void)backBtnClicked;

// 用不到 （取消请求）
- (void)cancelRequest;

@end

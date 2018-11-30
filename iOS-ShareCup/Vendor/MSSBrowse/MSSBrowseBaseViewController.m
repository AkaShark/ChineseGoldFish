//
//  MSSBrowseBaseViewController.m
//  MSSBrowse
//
//  Created by 于威 on 16/4/26.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSBrowseBaseViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+MSSScale.h"
#import "MSSBrowseRemindView.h"
#import "MSSBrowseActionSheet.h"
#import "MSSBrowseDefine.h"
#import <Photos/Photos.h>


@interface MSSBrowseBaseViewController ()

@property (nonatomic,strong)NSArray *browseItemArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)BOOL isRotate;// 判断是否正在切换横竖屏
@property (nonatomic,strong)UILabel *countLabel;// 当前图片位置
@property (nonatomic,strong)UIView *snapshotView;
@property (nonatomic,strong)NSMutableArray *verticalBigRectArray;
@property (nonatomic,strong)NSMutableArray *horizontalBigRectArray;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,assign)UIDeviceOrientation currentOrientation;
@property (nonatomic,strong)MSSBrowseActionSheet *browseActionSheet;
@property (nonatomic,strong)MSSBrowseRemindView *browseRemindView;
@property (nonatomic,strong)UIImage *cellImage;
@property (nonatomic,strong)PHAssetCollection *createdCollection;
@end

@implementation MSSBrowseBaseViewController

- (instancetype)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex
{
    self = [super init];
    if(self)
    {
        _browseItemArray = browseItemArray;
        _currentIndex = currentIndex;
        _isEqualRatio = YES;
        _isFirstOpen = YES;
        _screenWidth = MSS_SCREEN_WIDTH;
        _screenHeight = MSS_SCREEN_HEIGHT;
        _currentOrientation = UIDeviceOrientationPortrait;
        _verticalBigRectArray = [[NSMutableArray alloc]init];
        _horizontalBigRectArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)showBrowseViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
    {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else
    {
        _snapshotView = [rootViewController.view snapshotViewAfterScreenUpdates:NO];
    }
    [rootViewController presentViewController:self animated:NO completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createBrowseView];
}

- (void)initData
{
    for (MSSBrowseModel *browseItem in _browseItemArray)
    {
        CGRect verticalRect = CGRectZero;
        CGRect horizontalRect = CGRectZero;
        // 等比可根据小图宽高计算大图宽高
        if(_isEqualRatio)
        {
            if(browseItem.smallImageView)
            {
                verticalRect = [browseItem.smallImageView.image mss_getBigImageRectSizeWithScreenWidth:MSS_SCREEN_WIDTH screenHeight:MSS_SCREEN_HEIGHT];
                horizontalRect = [browseItem.smallImageView.image mss_getBigImageRectSizeWithScreenWidth:MSS_SCREEN_HEIGHT screenHeight:MSS_SCREEN_WIDTH];
            }
        }
        NSValue *verticalValue = [NSValue valueWithCGRect:verticalRect];
        [_verticalBigRectArray addObject:verticalValue];
        NSValue *horizontalValue = [NSValue valueWithCGRect:horizontalRect];
        [_horizontalBigRectArray addObject:horizontalValue];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    // 改用[UIApplication sharedApplication].keyWindow.rootViewController.view，防止present新viewController坐标转换不准问题
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
}

- (void)createBrowseView
{
    self.view.backgroundColor = [UIColor blackColor];
    if(_snapshotView)
    {
        _snapshotView.hidden = YES;
        [self.view addSubview:_snapshotView];
    }
    
    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    // 布局方式改为从上至下，默认从左到右
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // Section Inset就是某个section中cell的边界范围
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 每行内部cell item的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 每行的间距
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    [_collectionView registerClass:[MSSBrowseCollectionViewCell class] forCellWithReuseIdentifier:@"MSSBrowserCell"];
    _collectionView.contentOffset = CGPointMake(_currentIndex * (_screenWidth + kBrowseSpace), 0);
    [_bgView addSubview:_collectionView];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_countLabel];
    
    _browseRemindView = [[MSSBrowseRemindView alloc]initWithFrame:_bgView.bounds];
    [_bgView addSubview:_browseRemindView];
}


#pragma mark UIColectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSBrowseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSBrowserCell" forIndexPath:indexPath];
    if(cell)
    {        
        MSSBrowseModel *browseItem = [_browseItemArray objectAtIndex:indexPath.row];
        // 还原初始缩放比例
        cell.zoomScrollView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        cell.zoomScrollView.zoomScale = 1.0f;
        // 将scrollview的contentSize还原成缩放前
        cell.zoomScrollView.contentSize = CGSizeMake(_screenWidth, _screenHeight);
        cell.zoomScrollView.zoomImageView.contentMode = browseItem.smallImageView.contentMode;
        cell.zoomScrollView.zoomImageView.clipsToBounds = browseItem.smallImageView.clipsToBounds;
        [cell.loadingView mss_setFrameInSuperViewCenterWithSize:CGSizeMake(30, 30)];
        CGRect bigImageRect = [_verticalBigRectArray[indexPath.row] CGRectValue];
        if(_currentOrientation != UIDeviceOrientationPortrait)
        {
            bigImageRect = [_horizontalBigRectArray[indexPath.row] CGRectValue];
        }
        [self loadBrowseImageWithBrowseItem:browseItem Cell:cell bigImageRect:bigImageRect];
        
        __weak __typeof(self)weakSelf = self;
        [cell tapClick:^(MSSBrowseCollectionViewCell *browseCell) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf tap:browseCell];
        }];
        [cell longPress:^(MSSBrowseCollectionViewCell *browseCell) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if([[SDImageCache sharedImageCache]diskImageExistsWithKey:browseItem.bigImageUrl])
            {
                [strongSelf longPress:browseCell];
            }
        }];
    }
    return cell;
}

// 子类重写此方法
- (void)loadBrowseImageWithBrowseItem:(MSSBrowseModel *)browseItem Cell:(MSSBrowseCollectionViewCell *)cell bigImageRect:(CGRect)bigImageRect
{

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _browseItemArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_screenWidth + kBrowseSpace, _screenHeight);
}

#pragma mark UIScrollViewDeletate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!_isRotate)
    {
        _currentIndex = scrollView.contentOffset.x / (_screenWidth + kBrowseSpace);
        _countLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)_currentIndex + 1,(long)_browseItemArray.count];
    }
    _isRotate = NO;
}

#pragma mark Tap Method
- (void)tap:(MSSBrowseCollectionViewCell *)browseCell
{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    if(_snapshotView)
    {
        _snapshotView.hidden = NO;
    }
    else
    {
        self.view.backgroundColor = [UIColor clearColor];
    }
    // 集合视图背景色设置为透明
    _collectionView.backgroundColor = [UIColor clearColor];
    // 动画结束前不可点击透明背景后的内容
    _collectionView.userInteractionEnabled = NO;
    // 显示状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    // 停止加载
    NSArray *cellArray = _collectionView.visibleCells;
    for (MSSBrowseCollectionViewCell *cell in cellArray)
    {
        [cell.loadingView stopAnimation];
    }
    [_countLabel removeFromSuperview];
    _countLabel = nil;
    
    NSIndexPath *indexPath = [_collectionView indexPathForCell:browseCell];
    browseCell.zoomScrollView.zoomScale = 1.0f;
    MSSBrowseModel *browseItem = _browseItemArray[indexPath.row];
    /*
     建议小图列表的collectionView尽量不要复用，因为当小图的列表collectionview复用时，传进来的BrowseItem数组只有当前显示cell的smallImageView，在当前屏幕外的cell上的小图由于复用关系实际是没有的，所以只能有简单的渐变动画
     */
    if(browseItem.smallImageView)
    {
        CGRect rect = [self getFrameInWindow:browseItem.smallImageView];
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        if(_currentOrientation == UIDeviceOrientationLandscapeLeft)
        {
            transform = CGAffineTransformMakeRotation(- M_PI / 2);
            rect = CGRectMake(rect.origin.y, MSS_SCREEN_WIDTH - rect.size.width - rect.origin.x, rect.size.height, rect.size.width);
        }
        else if(_currentOrientation == UIDeviceOrientationLandscapeRight)
        {
            transform = CGAffineTransformMakeRotation(M_PI / 2);
            rect = CGRectMake(MSS_SCREEN_HEIGHT - rect.size.height - rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
        }
        [UIView animateWithDuration:0.5 animations:^{
            browseCell.zoomScrollView.zoomImageView.transform = transform;
            browseCell.zoomScrollView.zoomImageView.frame = rect;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }];
    }
}

- (void)longPress:(MSSBrowseCollectionViewCell *)browseCell
{
    [_browseActionSheet removeFromSuperview];
    _browseActionSheet = nil;
    __weak __typeof(self)weakSelf = self;
    _browseActionSheet = [[MSSBrowseActionSheet alloc]initWithTitleArray:@[@"保存图片",@"复制图片地址"] cancelButtonTitle:@"取消" didSelectedBlock:^(NSInteger index) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf browseActionSheetDidSelectedAtIndex:index currentCell:browseCell];
    }];
    [_browseActionSheet showInView:_bgView];
}

#pragma mark StatusBar Method
- (BOOL)prefersStatusBarHidden
{
    if(!_collectionView.userInteractionEnabled)
    {
        return NO;
    }
    return YES;
}

#pragma mark Orientation Method
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
    {
        _isRotate = YES;
        _currentOrientation = orientation;
        if(_currentOrientation == UIDeviceOrientationPortrait)
        {
            _screenWidth = MSS_SCREEN_WIDTH;
            _screenHeight = MSS_SCREEN_HEIGHT;
            [UIView animateWithDuration:0.5 animations:^{
                _bgView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        else
        {
            _screenWidth = MSS_SCREEN_HEIGHT;
            _screenHeight = MSS_SCREEN_WIDTH;
            if(_currentOrientation == UIDeviceOrientationLandscapeLeft)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    _bgView.transform = CGAffineTransformMakeRotation(- M_PI / 2);
                }];
            }
        }
        _bgView.frame = CGRectMake(0, 0, MSS_SCREEN_WIDTH, MSS_SCREEN_HEIGHT);
        _browseRemindView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight);
        if(_browseActionSheet)
        {
            [_browseActionSheet updateFrame];
        }
        _countLabel.frame = CGRectMake(0, _screenHeight - 50, _screenWidth, 50);
        [_collectionView.collectionViewLayout invalidateLayout];
        _collectionView.frame = CGRectMake(0, 0, _screenWidth + kBrowseSpace, _screenHeight);
        _collectionView.contentOffset = CGPointMake((_screenWidth + kBrowseSpace) * _currentIndex, 0);
        [_collectionView reloadData];
    }
}

#pragma mark MSSActionSheetClick
- (void)browseActionSheetDidSelectedAtIndex:(NSInteger)index currentCell:(MSSBrowseCollectionViewCell *)currentCell
{    // 保存图片
    if(index == 0)
    {
        _cellImage = currentCell.zoomScrollView.zoomImageView.image;
//        UIImageWriteToSavedPhotosAlbum(currentCell.zoomScrollView.zoomImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [self saveImageToPhoto];
    }
    // 复制图片地址
    else if(index == 1)
    {
        MSSBrowseModel *currentBwowseItem = _browseItemArray[_currentIndex];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = currentBwowseItem.bigImageUrl;
        [self showBrowseRemindViewWithText:@"复制图片地址成功"];
    }
}

- (void)saveImageToPhoto
{
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
//    请求/检查访问权限
//    如果用户还没有做出选择会自动弹出弹框用户做出选择后才会调用block
//    如果之前做过选择会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied)
            {
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"打开");
                }
            }
            else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                [self saveImageIntoAlbum];
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                //                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];
}
#pragma mark - 保存图片到自定义相册
- (void)saveImageIntoAlbum
{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
//        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
//        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}
#pragma mark - 获得当前App对应的自定义相册
- (PHAssetCollection *)createdCollection
{
    // 获得APP名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

#pragma mark - 获得相片
- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.cellImage].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *text = nil;
    if(error)
    {
        text = @"保存图片失败";
    }
    else
    {
        text = @"保存图片成功";
    }
    [self showBrowseRemindViewWithText:text];
}

#pragma mark RemindView Method
- (void)showBrowseRemindViewWithText:(NSString *)text
{
    [_browseRemindView showRemindViewWithText:text];
    _bgView.userInteractionEnabled = NO;
    [self performSelector:@selector(hideRemindView) withObject:nil afterDelay:0.7];
}

- (void)hideRemindView
{
    [_browseRemindView hideRemindView];
    _bgView.userInteractionEnabled = YES;
}

@end

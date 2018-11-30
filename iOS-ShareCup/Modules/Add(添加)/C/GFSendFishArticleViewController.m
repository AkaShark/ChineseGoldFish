//
//  GFSendFishArticleViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/17.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFSendFishArticleViewController.h"
#import "UITextView+Extension.h"
#import "IQKeyboardManager.h"
#import <AddressBook/AddressBook.h>
#import "nsstring+URL.h"

@interface GFSendFishArticleViewController ()<UITextViewDelegate>
@property(nonatomic, strong)  CLLocation *currLocation;
@property(nonatomic,strong) NSString *altitudeStr;
@property(strong,nonatomic) CLLocationManager *locationManager;


@end

@implementation GFSendFishArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view..
    
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.08)];
    
    _navigationView.backgroundColor = StandColor;
    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.view addSubview:_navigationView];
    
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width *0.05, self.view.frame.size.height * 0.035, 50, 30)];
    
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [NSString translation:@"取消" CallbackStr:^(NSString * _Nonnull str) {
        [self->_cancelBtn setTitle:str forState:UIControlStateNormal];
    }];
    
//    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationView addSubview:_cancelBtn];
    
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.035, 50, 30)];
    
    [NSString translation:@"发送" CallbackStr:^(NSString * _Nonnull str) {
        [self->_sendBtn setTitle:str forState:UIControlStateNormal];
    }];
//    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationView addSubview:_sendBtn];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 38, self.view.frame.size.height * 0.03, 80, 30)];
    
    [NSString translation:@"发鱼文" CallbackStr:^(NSString * _Nonnull str) {
        [self->_titleLabel setText:str];
    }];
    
//    [_titleLabel setText:@"发鱼文"];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_titleLabel setTextColor:[UIColor lightGrayColor]];
    
    [self.navigationView addSubview:_titleLabel];
    
    
    
    _fishArticleView = [[UITextView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.08, self.view.frame.size.width, self.view.frame.size.height)];
    [_fishArticleView becomeFirstResponder];
    _fishArticleView.backgroundColor = [UIColor whiteColor];
    [NSString translation:@"分享新鲜事…" CallbackStr:^(NSString * _Nonnull str) {
        [_fishArticleView setPlaceholderWithText:str Color:[UIColor lightGrayColor]];
    }];
//    [_fishArticleView setPlaceholderWithText:@"分享新鲜事…" Color:[UIColor lightGrayColor]];
    _fishArticleView.font = [UIFont systemFontOfSize:18];
    
    
    [self.view addSubview:_fishArticleView];
    
    
    _locationLbl = [[UILabel alloc]init];
    _locationLbl.font = [UIFont systemFontOfSize:18];
    _locationLbl.textColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationBtnClick)];
    [_locationLbl addGestureRecognizer:tap];
    _locationLbl.textAlignment = NSTextAlignmentCenter;
    _locationLbl.userInteractionEnabled = YES;
    [NSString translation:@"你在哪里？" CallbackStr:^(NSString * _Nonnull str) {
        _locationLbl.text = str;
    }];
//    _locationLbl.text = @"你在哪里？";
    _locationLbl.layer.borderWidth = 0.5;
    _locationLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _locationLbl.layer.cornerRadius = 15;
    
    
    [self.fishArticleView addSubview:_locationLbl];
    
    
    //键盘出现的通知 使用通知监听系统的keyboardshow通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    //控制自动键盘功能是否启用
    [IQKeyboardManager sharedManager].enable = NO;
    //键盘弹出时，点击背景，键盘收回
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

//键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification{
    
    //    获取键盘的大小
    CGRect keyBoardFrame = [[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    获取高度
    CGFloat height = keyBoardFrame.size.height;
    NSLog(@"%f",height);
    
    __block UILabel *lbl = _locationLbl;
    [UIView animateWithDuration:0.5 animations:^{
        lbl.frame = CGRectMake(10, height *0.97, 120, 30);
    }];
    
    
}

- (void)keyboardWillBeHiden:(NSNotification *)notification{
    __block UILabel *lbl = _locationLbl;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        lbl.frame = CGRectMake(10, weakSelf.view.frame.size.height*0.85, 120, 30);
    }];
    
}
// 在使用通知的时候一定要 写这个 取消通知 不然的话 会crash
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
//点击我在哪
- (void)locationBtnClick{
    
    [self createLocationManager];
}

- (void)cancelBtnClick{
    [_fishArticleView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnClick{
    
//    取出当前用户名
    NSDictionary *dict = [[UserManager defaultManager] getUserDict];
    NSString *user = dict[@"userName"];
    NSString *urlencode =[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/insterArticle.php?phone=%@&article=%@",user,_fishArticleView.text];
//    url编码
    urlencode = [NSString encodeString:urlencode];
    [POST_GET GET:urlencode parameters:nil succeed:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    [_fishArticleView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark =====定位 =====
//初始化
- (void)createLocationManager
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate=self;
    //  定位频率,每隔多少米定位一次
    // 距离过滤器，移动了几米之后，才会触发定位的代理函数
    self.locationManager.distanceFilter = 1000;
    
    // 定位的精度，越精确，耗电量越高
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;//导航
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        //获取授权认证
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //请求允许在前台获取用户位置的授权
    //    [self.locationManager requestWhenInUseAuthorization];
    //求允许在前后台都能获取用户位置的授权
    //    [self.locationManager requestAlwaysAuthorization ];
    //允许后台定位更新,进入后台后有蓝条闪动
    //    self.locationManager.allowsBackgroundLocationUpdates = YES;
    
    //判断定位设备是否能用和能否获得导航数据
    if ([CLLocationManager locationServicesEnabled]&&[CLLocationManager headingAvailable]){
        
        [self.locationManager startUpdatingLocation];//开启定位服务
        //        [self.locationManager startUpdatingHeading];//开始获得航向数据
        
        //        这个方法已被执行，就会回调下面的方法
        //        -(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
    }
    else{
        NSLog(@"asdasd");
        
        //        NSLog(@"不能获得航向数据");
        //        [self sendRequestToServer:@"张家口"];
        
    }
    
}
//获取位置 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.currLocation = [locations lastObject];
    
    self.altitudeStr  = [NSString stringWithFormat:@"%3.2f",
                         _currLocation.altitude];
    
    
    //基于CLGeocoder - 反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __block UILabel *lbl = self.locationLbl;
    [geocoder reverseGeocodeLocation:self.currLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       if ([placemarks count] > 0) {
                           
                           CLPlacemark *placemark = placemarks[0];
                           
                           NSDictionary *addressDictionary =  placemark.addressDictionary;
                           
                           NSString *street = [addressDictionary
                                               objectForKey:(NSString *)kABPersonAddressStreetKey];
                           street = street == nil ? @"": street;
                           
                           NSString *country = placemark.country;
                           
                           NSString * subLocality = placemark.subLocality;
                           
                           NSString *city = [addressDictionary
                                             objectForKey:(NSString *)kABPersonAddressCityKey];
                           
                           city = city == nil ? @"": city;
                           NSString *localStr =  [NSString stringWithFormat:@"%@/%@/%@ ", city,subLocality ,street];
                           CGSize size = [localStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
                           lbl.size = CGSizeMake(size.width, size.height);
                           lbl.text = localStr;
                           
                           
                           NSLog(@"%@",[NSString stringWithFormat:@"%@ \n%@ \n%@  %@ ",country, city,subLocality ,street]);
                           [self.locationManager stopUpdatingLocation];
                       }
                   }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  GFMeViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 09/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFMeViewController.h"
#import "GFPersonalInformationViewController.h"

@interface GFMeViewController ()

@end

@implementation GFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NSString translation:@"我的" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    
   
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 0, 12, 12)];
    
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightSettingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    ViewController *vc = [[ViewController alloc]init];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    backImage.image = [UIImage imageNamed:@"background"];
    [vc.view addSubview:backImage];
    [vc.view sendSubviewToBack:backImage];
    
   
    
}

- (void)rightSettingBtnClick{
    
    GFPersonalInformationViewController *personInfor = [[GFPersonalInformationViewController alloc]init];
    
    personInfor.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:personInfor animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

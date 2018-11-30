//
//  GFForgetPasswordViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/9/25.
//  Copyright © 2018年 刘述豪. All rights reserved.
//

#import "GFForgetPasswordViewController.h"
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height

@interface GFForgetPasswordViewController ()

@end

@implementation GFForgetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _forgetView = [[GFForgetPasswordView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    
    [_forgetView setUpTheUI];
    
    [self.view addSubview:_forgetView];
    
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

//
//  GFNewGudieViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/21.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFNewGudieViewController.h"

@interface GFNewGudieViewController ()

@end

@implementation GFNewGudieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    block回调
    !_callBack?:_callBack();
}

@end

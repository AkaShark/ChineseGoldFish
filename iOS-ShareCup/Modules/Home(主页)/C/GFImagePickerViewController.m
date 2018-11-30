//
//  GFImagePickerViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFImagePickerViewController.h"


@interface GFImagePickerViewController()
{
    NSInteger buttomBarHeight;
    NSInteger topBarHeight;
}

@end

@implementation GFImagePickerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}



@end

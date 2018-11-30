//
//  GFHistoryViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 12/09/2018.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFHistoryViewController.h"
#import "GFWebViewViewController.h"
@interface GFHistoryViewController ()

@end

@implementation GFHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GFWebViewViewController *VC = [[GFWebViewViewController alloc] init];
    VC.webUrl = @"http://47.104.211.62/GlodFish/GlodFishHistory.html";
    [NSString translation:@"金鱼历史" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
    [self addChildViewController:VC];
    [self.view addSubview:VC.view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

//
//  GFRecongitionViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFRecongitionViewController.h"
#import "GFWebViewViewController.h"
@interface GFRecongitionViewController ()
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation GFRecongitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI_config];
}

- (void)UI_config
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _imageView.image = self.image;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    GFRecognitionTableView *tableView = [[GFRecognitionTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:tableView];
    
    tableView.titleArray = (NSArray *)_nameArray;
    tableView.detailArray = (NSArray *)_scoreArray;
//    tableView.urlArray = (NSArray *)_urlArray;
    
    tableView.callBack = ^{
        [self.view removeFromSuperview];
    };
    
    __weak typeof(self) WeakSelf = self;
    tableView.pushView = ^(NSInteger index) {
        if(WeakSelf.urlArray.count > 1)
        {
            GFWebViewViewController *web = [[GFWebViewViewController alloc] init];
            web.webUrl = WeakSelf.urlArray[index];
            [self presentViewController:web animated:YES completion:nil];
        }
       
    };
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
}



@end

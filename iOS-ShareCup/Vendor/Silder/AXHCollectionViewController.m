//
//  AXHCollectionViewController.m
//  AXHProject
//
//  Created by kys-5 on 16/8/31.
//  Copyright © 2016年 kys-5. All rights reserved.
//

#import "AXHCollectionViewController.h"



@interface AXHCollectionViewController ()

@end

@implementation AXHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSString translation:@"关于我们" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];

    self.view.backgroundColor = [[UIColor alloc]initWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"金鱼3"]];
    imageView.frame = CGRectMake(0,60, KScreenWidth, KScreenHeight*0.3);
//    [imageView sizeToFit];
    [self.view addSubview:imageView];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"国家水产种质资源共享服务平台：",@"联系电话：+86 10 6867 3914",@"邮箱：liml@cafs.ac.cn", nil];
    for(int i=0;i<3;i++){
        UILabel *label = [[UILabel alloc]init];
            label.text = arr[i];
        
        label.textColor=[UIColor grayColor];
        NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
        
        paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
         NSDictionary *dic=@{NSFontAttributeName:label.font,NSParagraphStyleAttributeName:paragraphstyle.copy};
        CGRect rect;
        rect=[label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-16, self.view.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        label.frame =CGRectMake(10, self.view.frame.size.height*0.38+25+(i*rect.size.height), rect.size.width,rect.size.height);
        if (i == 3) {
            NSLog(@"%f",i*rect.size.height);
        }
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    UILabel *textLabel = [[UILabel alloc]init];
    
    textLabel.text = @"通讯地址：北京市丰台区中国水产科学研究院\n平台机构： http://zzzy.fishinfo.cn/";
    
    textLabel.textColor=[UIColor grayColor];
    textLabel.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(KScreenWidth-10, 9999);
    CGSize expectSize = [textLabel sizeThatFits:maximumLabelSize];
    textLabel.frame = CGRectMake(10, self.view.frame.size.height*0.55+8, expectSize.width, expectSize.height);
    [self.view addSubview:textLabel];
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

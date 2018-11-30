//
//  CASettingTableViewController.m
//  CamelliaApp
//
//  Created by kys-6 on 2017/11/5.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import "CASettingTableViewController.h"
#import "MBProgressHUD.h"
#import "SDAutoLayout.h"

@interface CASettingTableViewController ()

@end

@implementation CASettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = nil;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"setCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
         cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (indexPath.row == 0) {
        [NSString translation:@"推送消息" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        
        [NSString translation:@"是否开启推送" CallbackStr:^(NSString * _Nonnull str) {
            cell.detailTextLabel.text = str;
        }];
        
        UISwitch* switchOne = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth*0.8,10, KScreenWidth*0.15, 30)];
        [cell.contentView addSubview:switchOne];
    }else if(indexPath.row == 1){
        [NSString translation:@"清理缓存" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        
        [NSString translation:@"清理图片等资源，释放手机空间" CallbackStr:^(NSString * _Nonnull str) {
            cell.detailTextLabel.text = str;
        }];

    }else if(indexPath.row == 2){
        [NSString translation:@"多语言环境" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*0.7,10, KScreenWidth, 30)];
        [NSString translation:@"简体中文" CallbackStr:^(NSString * _Nonnull str) {
            label.text = str;
        }];
        [cell.contentView addSubview:label];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    bool tag = YES ;
    if(indexPath.row == 1){
        if (tag) {
            tag = NO;
//            MBProgressHUD* HUD = [[MBProgressHUD alloc] init];
//            [HUD setCenterY_sd:self.view.center.y+150];
//            [HUD setCenterX_sd:self.view.center.x];
//            HUD.mode = MBProgressHUDModeText;
//            //设置出现的时候可以交互
//            HUD.userInteractionEnabled = NO;
//            [HUD showAnimated:YES];
//            [HUD hideAnimated:YES afterDelay:0.8];
//            HUD.label.text =@"清理缓存成功";
//            [self.view addSubview:HUD];
        }
    }else if(indexPath.row == 2){
//        [[MOFSPickerManager shareManger]showPickerViewWithDataArray:@[@"简体中文",@"英语"] tag:1 title:nil cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(id model) {
        
//        } cancelBlock:^{
//
//        }];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

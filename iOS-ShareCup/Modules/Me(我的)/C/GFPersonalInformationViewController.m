//
//  GFPersonalInformationViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/10/16.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFPersonalInformationViewController.h"
#import "GFInformationChangeViewController.h"
#import "iOS_ShareCup-Swift.h"
#import "AFNetworking.h"
#import "UpLoadPhoto.h"

@interface GFPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>

@end

@implementation GFPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSString translation:@"编辑资料" CallbackStr:^(NSString * _Nonnull str) {
         self.title = str;
    }];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _inforArray = [NSArray arrayWithObjects:@"头像",@"昵称",@"签名",@"所在地", nil];
    
    _detailLabelArray = [NSArray arrayWithObjects:@" ",@"好的名字可以让你的朋友更容易记住你",@"展现个性的自己",@"让朋友更容易找到你",nil];
    
    _detailTextArray = [NSMutableArray array];
    
    _personInforTableView = [[UITableView alloc]init];
    
    _personInforTableView.frame = self.view.frame;
    
    _personInforTableView.delegate = self;
    
    _personInforTableView.dataSource = self;
    
    _personInforTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _personInforTableView.scrollEnabled = NO;
    
    _personInforTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:_personInforTableView];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _dict = [[UserManager defaultManager]getUserDict];
    _changeDict = [NSMutableDictionary dictionaryWithDictionary:_dict];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _inforArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellStr = @"cellStr";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.textLabel.text = self.inforArray[indexPath.row];
    
    //    cell.detailTextLabel.text = self.detailArray[indexPath.row];
    
    NSDictionary *dict = [UserManager defaultManager].getUserDict;
    if (indexPath.row == 0) {
        [NSString translation:@"头像" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
    }else if (indexPath.row == 1){
        [NSString translation:@"昵称" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        cell.detailTextLabel.text = dict[@"nickName"];
    }else if (indexPath.row == 2){
        [NSString translation:@"签名" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        cell.detailTextLabel.text = dict[@"signature"];
    }else if (indexPath.row == 3){
        [NSString translation:@"所在地" CallbackStr:^(NSString * _Nonnull str) {
            cell.textLabel.text = str;
        }];
        cell.detailTextLabel.text = _changeDict[@"area"];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    GFInformationChangeViewController *inforVC = [[GFInformationChangeViewController alloc]init];
    
    if (indexPath.row == 0) {
        _imagePicker = [[UIImagePickerController alloc]init];
        
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        _imagePicker.delegate = self;
        
        _imagePicker.allowsEditing = YES;
        
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
    if (indexPath.row == 1){
        inforVC.labelStr = _detailLabelArray[indexPath.row];
        
        inforVC.passValueBlock = ^(NSString * _Nonnull cellDetailText) {
            self.cell1Str = cell.detailTextLabel.text = cellDetailText;
            
            [self.changeDict setValue:self.cell1Str forKey:@"nickName"];
        };
        
        [self.navigationController pushViewController:inforVC animated:YES];
    }
    if (indexPath.row == 2) {
        inforVC.labelStr = _detailLabelArray[indexPath.row];
        
        inforVC.passValueBlock = ^(NSString * _Nonnull cellDetailText) {
            self.cell2Str = cell.detailTextLabel.text = cellDetailText;
            [self.changeDict setValue:self.cell2Str forKey:@"signature"];
            
        };
        
        [self.navigationController pushViewController:inforVC animated:YES];
    }
    if (indexPath.row == 3)
    {
        inforVC.labelStr = _detailLabelArray[indexPath.row];
        
        inforVC.passValueBlock = ^(NSString * _Nonnull cellDetailText) {
            
            self.cell3Str = cell.detailTextLabel.text = cellDetailText;
            
            [self.changeDict setValue:self.cell3Str forKey:@"area"];
            
        };
        
        [self.navigationController pushViewController:inforVC animated:YES];
        
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [[UserManager defaultManager]initWithDict:_changeDict];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://47.104.211.62/GlodFish/changeUser.php?phone=%@&nickName=%@&signature=%@&area=%@",_changeDict[@"userName"],_changeDict[@"nickName"],_changeDict[@"signature"],_changeDict[@"area"]];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [POST_GET GET:urlStr parameters:nil succeed:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%ld",(long)error.code);
    }];
    
}

//选择某个图片时系统调用的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self getImagePath:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//取消选择图片时系统调用的代理方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//照片获取本地路径转换 (保存本地的时候先去删除下。。。)
- (NSString *)getImagePath:(UIImage *)image{
    
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    }else{
        data = UIImagePNGRepresentation(image);
    }
    
    //图片保存的路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    //文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
//    [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *userStr = _dict[@"userName"];
    
    NSString *imagePath = [[NSString alloc]initWithFormat:@"/%@headIcon.png",userStr];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", cachePath,imagePath];
    

    
    [data writeToFile:filePath atomically:YES];
    
    
    

    
//    NSArray *parameters = @[filePath,userStr];
//     设计的不好 抽象方法会更好的
    [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/rsf_list_bucket.php?imageName=%@",userStr] parameters:nil succeed:^(id responseObject) {
        
        if ([responseObject[@"isExit"] isEqualToString: @"0"])
        {
//            [self performSelector:@selector(uploadPhoto:) withObject:parameters/*可传任意类型参数*/ afterDelay:1.0];
            [[UpLoadPhoto detaultManager] uploadImageToQNData:data Name:userStr success:^(NSString * _Nonnull result) {
                NSLog(@"%@",result);
            } failure:^(NSString * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        }
        else{
            [POST_GET GET:[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/rs_delete.php?imageName=%@",userStr] parameters:nil succeed:^(id responseObject) {
                
                [[UpLoadPhoto detaultManager] uploadImageToQNData:data Name:userStr success:^(NSString * _Nonnull result) {
                    NSLog(@"%@",result);
                } failure:^(NSString * _Nonnull error) {
                    NSLog(@"%@",error);
                }];
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
      
    } failure:^(NSError *error) {
        
    }];
    return filePath;
}

//上传
//- (void)uploadPhoto:(NSArray *)data
//{
//    NSString *filePath = data[0];
//    NSString *userStr = data[1];
////    [[UpLoadPhoto detaultManager]uploadImageToFilePath:filePath Name:userStr success:^(NSString * _Nonnull result) {
////        NSLog(@"%@",result);
////    } failure:^(NSString * _Nonnull error) {
////        NSLog(@"%@",error);
////    }];
//    [UpLoadPhoto detaultManager]
//}









@end

//
//  GFMyCollectionViewController.m
//  iOS-ShareCup
//
//  Created by kys-3 on 2018/11/12.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFMyCollectionViewController.h"
#import "GFMyCollectionTableViewCell.h"
#import "GFShowDetailModel.h"
#import "GFShowClassDetailViewController.h"

@interface GFMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation GFMyCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
//    NSUserdefault
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //取出
    _dataArray = [user objectForKey:@"collection"];
//    解档(将data数据转换为Model)
    if (_dataArray.count == 0) {
        _dataArray = [[NSArray alloc]init];
    }else{
//        接档
        _modelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in _dataArray) {
            GFShowDetailModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)dic[@"model"]];
            [_modelArray addObject:model];
        }
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
    
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GFMyCollectionTableViewCell *cell = [GFMyCollectionTableViewCell cellWithTableView:tableView];
//    cell.backgroundColor = [UIColor redColor];
//    数据传递
//    sdwebimage
    [cell.mainImageView setImageURL:[NSURL URLWithString:((GFShowDetailModel *)_modelArray[indexPath.row]).imageUrl]];
    cell.titleLabel.text = ((GFShowDetailModel *)_modelArray[indexPath.row]).className;
    cell.detailLabel.text = ((GFShowDetailModel *)_modelArray[indexPath.row]).detailStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    例子
    GFShowClassDetailViewController *detailVC = [GFShowClassDetailViewController new];
    //    detailVC.
    detailVC.model = _modelArray[indexPath.row] ;
    detailVC.isTransitrion = YES;
    detailVC.type = _dataArray[indexPath.row][@"type"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end

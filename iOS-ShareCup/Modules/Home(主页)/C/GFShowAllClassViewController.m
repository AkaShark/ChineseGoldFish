//
//  GFShowAllClassViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/10/4.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFShowAllClassViewController.h"
#import "UIImageView+WebCache.h"
#import "GFShowDetaiTableViewCell.h"
#import "GFShowVarietyModel.h"

@interface GFShowAllClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,strong) UILabel *nameLbl;

@end

@implementation GFShowAllClassViewController

- (void)viewWillAppear:(BOOL)animated
{
    //    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //不去适配导航栏 ！！！
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    [self requestData];
}
//请求数据
- (void)requestData
{
//    URLencode
    NSString *url =[NSString stringWithFormat:@"http://47.104.211.62/GlodFish/glodFishSelectVariety.php?name=%@",self.varityName];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.modelArray = [[NSMutableArray alloc] init];
    __weak typeof(self) weakSelf = self;
    __block typeof(NSMutableArray *) modelArray = self.modelArray;
    [POST_GET GET:url parameters:nil succeed:^(id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
//        数据data 包含了 类名 种名 介绍 图片
        weakSelf.dataArray = dict[@"result"][@"ClassName"][0];
        for (int i =0 ; i<weakSelf.dataArray.count; i++)
        {
            GFShowVarietyModel *modle = [[GFShowVarietyModel alloc] init];
            modle.imageURl = weakSelf.dataArray[4];
            modle.detailStr = weakSelf.dataArray[3];
            modle.varietyName = weakSelf.dataArray[2];
            [modelArray addObject:modle];
        }
        NSString *str = weakSelf.dataArray[4];
        NSArray *array = [str componentsSeparatedByString:@","];
        [weakSelf.headImgView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];
        [weakSelf.tableView reloadData];
//        weakSelf.title = weakSelf.dataArray[2];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, KScreenWidth, KScreenHeight+20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headImgView;
    _nameLbl = [[UILabel alloc]init];
    _nameLbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    _nameLbl.textColor = [UIColor lightGrayColor];
    [self.headImgView addSubview:_nameLbl];
    
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.bottom.equalTo(@0);
    }];
    
    
//    [self.tableView registerClass:[GFShowDetaiTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GFShowDetaiTableViewCell class])];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   GFShowDetaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GFShowDetaiTableViewCell class])];
    if (!cell)
    {
        cell = [[GFShowDetaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([GFShowDetaiTableViewCell class])];
    }
    if(_modelArray.count > 0)
    {
        cell.model = _modelArray[indexPath.row];
        _nameLbl.text = [NSString stringWithFormat:@"%@--%@",_dataArray[1],_dataArray[2]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (UIImageView *)headImgView
{
    if (!_headImgView) 
    {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 250)];
        NSArray *url = [self.imageURl componentsSeparatedByString:@","];
        [_headImgView sd_setImageWithURL:[NSURL URLWithString:url[0]] placeholderImage:[UIImage imageNamed:@"noDataImage"]];

    }
    return _headImgView;
}




@end

//
//  GFRecognitionTableView.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/11/5.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFRecognitionTableView.h"
#import "GFRecognitionTableViewCell.h"



@interface GFRecognitionTableView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation GFRecognitionTableView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFRecognitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recognition"];
    if (!cell)
    {
        cell = [[GFRecognitionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recognition"];
    }

    cell.backgroundColor = CNavBgColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    
    CGFloat progress = [_detailArray[indexPath.section] floatValue];
    [cell passThedataTextLabel:_titleArray[indexPath.section] DetailStr:_detailArray[indexPath.section] Progress:progress];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFRecognitionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.titleLbl.text isEqualToString:@"关闭"])
    {
        if (self.callBack)
        {
            self.callBack();
        }
    }
    else{
        if (self.pushView)
        {
            self.pushView(indexPath.row);
        }
    }
    
   
}

@end

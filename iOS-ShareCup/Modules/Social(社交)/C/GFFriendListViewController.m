//
//  GFFriendListViewController.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFFriendListViewController.h"
#import "GFChatListTableViewCell.h"
@interface GFFriendListViewController ()

@end


@implementation GFFriendListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[RCIM sharedRCIM] connectWithToken:@"sB0hCIq1uDO7ghGw2u6fRMpvPOzg5iJtLEVLzvh9wRsJ7BiEeqgASWt6mbh5YNUODTj0q9EBnqQjI0n7MR+JHQ=="     success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token错误");
        }];
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
       
    }
    return self;
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [NSString translation:@"鱼圈" CallbackStr:^(NSString * _Nonnull str) {
        self.title = str;
    }];
//    self.title = @"鱼圈";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.conversationListTableView.tableFooterView = [UIView new];
    self.conversationListTableView.delegate = self;
    self.conversationListTableView.dataSource = self;
    self.conversationListTableView.backgroundColor = StandColor;
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
}

#pragma mark - 设置cell的高度
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}



#pragma mark - 设置cell的删除事件
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}




#pragma mark - 修改cell样式
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType != RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        RCConversationCell *RCcell = (RCConversationCell *)cell;
        RCcell.conversationTitle.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
        RCcell.messageContentLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        RCcell.messageCreatedTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    }
}


#pragma mark - 自定义cell
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GFChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell"];
    if (!cell)
    {
        cell = [[GFChatListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RongYunListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    cell.myModel = model;
    return cell;
}

-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        if(model.conversationType == ConversationType_PRIVATE){
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    }
    return dataSource;
}

#pragma mark - cell选中事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
   
        //会话列表
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.hidesBottomBarWhenPushed = YES;
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
        [self.navigationController pushViewController:conversationVC animated:YES];
    
}
    



@end

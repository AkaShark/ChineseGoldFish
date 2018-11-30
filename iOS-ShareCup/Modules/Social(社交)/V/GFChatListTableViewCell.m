//
//  GFChatListTableViewCell.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "GFChatListTableViewCell.h"

@interface GFChatListTableViewCell()

@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *timeLbl;
@property (nonatomic,strong) UILabel *detailLbl;

@end
@implementation GFChatListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，默
    }
    return self;
}

- (void)setUpUI
{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x-10, self.frame.origin.y, self.frame.size.width-20, self.frame.size.height)];
//    bgView.layer.cornerRadius = 14;
//    bgView.layer.masksToBounds = YES;
//    [self.contentView addSubview:bgView];
    
    _userImageView = [UIImageView new];
    _userImageView.layer.cornerRadius = 10;
    _userImageView.layer.masksToBounds = YES;
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.left.equalTo(@18);
        make.width.height.equalTo(@48);
    }];
    
    _nameLbl = [UILabel new];
    _nameLbl.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    _nameLbl.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    [self addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top);
        make.left.equalTo(self.userImageView.mas_right).offset(20);
    }];
    
    _detailLbl = [UILabel new];
    _detailLbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    _detailLbl.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
    [self addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameLbl).offset(27);
        make.left.equalTo(self.nameLbl);
        make.bottom.equalTo(@-16);
    }];
    
    _timeLbl = [UILabel new];
    _timeLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    
    _timeLbl.textColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1];
    [self addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLbl);
        make.right.equalTo(@-14);
    }];
    
    
}

- (void)setMyModel:(RCConversationModel *)myModel
{
    _myModel = myModel;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:myModel.receivedTime/1000];
//    NSString *timeString = [[self stringFromDate:date] substringToIndex:10];
    NSString *temp = [self getyyyymmdd];
    NSString *nowDateString = [NSString stringWithFormat:@"%@-%@-%@",[temp substringToIndex:4],[temp substringWithRange:NSMakeRange(4, 2)],[temp substringWithRange:NSMakeRange(6, 2)]];
    _timeLbl.text = nowDateString;
    
    
    if ([myModel.lastestMessage isKindOfClass:[RCTextMessage class]]) {
         _detailLbl.text = [myModel.lastestMessage valueForKey:@"content"];
        
    }else if ([myModel.lastestMessage isKindOfClass:[RCImageMessage class]]){
        
        if ([myModel.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
            //我自己发的
            RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
            
            if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                [NSString translation:@"图片消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text =[NSString stringWithFormat:str];
                }];
//                _detailLbl.text =[NSString stringWithFormat:@"图片消息，点击查看"];
            }else{
                [NSString translation:@"图片消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text =[NSString stringWithFormat:str];
                }];
//                _detailLbl.text =[NSString stringWithFormat:@"图片消息，点击查看"];
                
            }
        }else{
            [NSString translation:@"图片消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                _detailLbl.text =[NSString stringWithFormat:str];
            }];
//            _detailLbl.text =[NSString stringWithFormat:@"图片消息，点击查看"] ;
        }
        
    }else if ([myModel.lastestMessage isKindOfClass:[RCVoiceMessage class]]){
        if ([myModel.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
            //我自己发的
            RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
            if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                [NSString translation:@"语音消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text = [NSString stringWithFormat:str,myselfInfo.name];
                }];
//                _detailLbl.text = [NSString stringWithFormat:@"语音消息，点击查看",myselfInfo.name];
                
            }else{
                [NSString translation:@"语音消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text = [NSString stringWithFormat:str,myselfInfo.name];
                }];
//                _detailLbl.text = [NSString stringWithFormat:@"语音消息，点击查看",myselfInfo.name];
            }
        }else{
            [NSString translation:@"语音消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                 _detailLbl.text = [NSString stringWithFormat:str];
            }];
//            _detailLbl.text = [NSString stringWithFormat:@"语音消息，点击查看"];
        }
    }
    else if ([myModel.lastestMessage isKindOfClass:[RCLocationMessage class]]){
        if ([myModel.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
            //我自己发的
            RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
            if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                [NSString translation:@"位置消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text = [NSString stringWithFormat:str,myselfInfo.name];
                }];
//                _detailLbl.text = [NSString stringWithFormat:@"位置消息，点击查看",myselfInfo.name];
            }else{
                [NSString translation:@"位置消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                    _detailLbl.text = [NSString stringWithFormat:str,myselfInfo.name];
                }];
//                _detailLbl.text = [NSString stringWithFormat:@"位置消息，点击查看",myselfInfo.name];
            }
        }else{
            [NSString translation:@"位置消息，点击查看" CallbackStr:^(NSString * _Nonnull str) {
                _detailLbl.text = [NSString stringWithFormat:str];
            }];
//            _detailLbl.text = [NSString stringWithFormat:@"位置消息，点击查看"];
        }
    }
//    判断id换成用户名字
   _nameLbl.text = myModel.targetId;
    
    _userImageView.image = [UIImage imageNamed:@"金鱼1"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
-(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
//修改tableViewCell 的大小位置 之前没学习过这个
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}


@end

//
//  GFChatListTableViewCell.h
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/20.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface GFChatListTableViewCell : RCConversationBaseCell
@property (nonatomic,strong) RCConversationModel *myModel;
@end

NS_ASSUME_NONNULL_END

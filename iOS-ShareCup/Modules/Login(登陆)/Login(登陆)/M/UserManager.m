//
//  UserManager.m
//  iOS-ShareCup
//
//  Created by kys-20 on 2018/9/27.
//  Copyright © 2018 刘述豪. All rights reserved.
//

#import "UserManager.h"

@interface UserManager()

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *isLogin;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *area;


@end

@implementation UserManager

+ (instancetype)defaultManager
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:nil];
    });
    
    return manager;
}

- (void)initWithDict:(NSDictionary *)dict
{
    [UserManager defaultManager].userName = dict[@"userName"];
    [UserManager defaultManager].isLogin = dict[@"isLogin"];
    [UserManager defaultManager].nickName = dict[@"nickName"];
    [UserManager defaultManager].signature = dict[@"signature"];
    [UserManager defaultManager].area = dict[@"area"];
}

- (NSDictionary *)getUserDict
{
    if (![UserManager defaultManager].userName)
    {
         NSDictionary *dict = @{@"userName":@"",@"isLogin":@"0"};
         return dict;
    }
    else
    {
        NSDictionary *dict = @{@"userName":self.userName,@"isLogin":self.isLogin,@"nickName":self.nickName,@"signature":self.signature,@"area":self.area};
        
         return dict;
    }
    
   
}

//+ (instancetype)userManagerWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//
//- (instancetype) initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init])
//    {
//        self.userName = dict[@"user_id"];
//        self.isLogin = dict[@"isLogin"];
//        
//    }
//    return self;
//}



@end

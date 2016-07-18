//
//  YLLAccountManager.m
//  yilule
//
//  Created by lidi on 15/6/9.
//  Copyright (c) 2015年 topview. All rights reserved.
//

#import "YLLAccountManager.h"

#define Account_UserDefaults    [NSUserDefaults standardUserDefaults]

static NSString *kUserDefaultsFirstLaunch       = @"kUserDefaultsFirstLaunch";
static NSString *kUserDefaultsAccountID         = @"kUserDefaultsAccountID";
static NSString *kUserDefaultsUserID            = @"kUserDefaultsUserID";
static NSString *kUserDefaultsIsLogined         = @"kUserdefaultsIsLogined";
static NSString *kUserDefaultsPhoneNumber       = @"kUserDefaultsPhoneNumber";
static NSString *kUserDefaultsToken             = @"kUserDefaultsToken";
static NSString *kUserDefaultsEmail             = @"kUserDefaultsEmail";
static NSString *kUserDefaultsEmailIsVerify     = @"kUSerDefaultsEmailIsVerify";
static NSString *kUserDefaultsNickName          = @"kUserDefaultsNickName";
static NSString *kUserDefaultsIsNickNameChange  = @"kUserDefaultsIsNickNameChange";
static NSString *kUserDefaultsUserIcon          = @"kUserDefaultsUserIcon";
static NSString *kUserDefaultsIsSinaBinding     = @"kUserDefaultsIsSinaBinding";
static NSString *kUserDefaultsIsWechatBinding   = @"kUserDefaultsIsWechatBinding";
static NSString *kUserDefaultsIsQQBinding       = @"kUserDefaultsIsQQBinding";

static NSString *kUserDefaultsSite_0_City       = @"kUserDefaultsSite_0_City";
static NSString *kUserDefaultsSite_1_District   = @"kUserDefaultsSite_1_District";
static NSString *kUserDefaultsSite_2_Street     = @"kUserDefaultsSite_2_Street";
static NSString *kUserDefaultsSite_3_Depart     = @"kUserDefaultsSite_3_Depart";

static NSString *kUserDefaultsUsedpoints     = @"kUserDefaultsUsedpoints";

static NSString *kUserDefaultsSite     = @"kUserDefaultsSite";

static NSString *kUserDefaultsTime    = @"kUserDefaultsTime";

@implementation YLLAccountManager

+ (instancetype)sharedAccountManager
{
    static YLLAccountManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [self new];
    });
    return sharedAccountManagerInstance;
}

- (BOOL)f_first_launch
{
    NSNumber *firstLaunch = [Account_UserDefaults objectForKey:kUserDefaultsFirstLaunch];
    if (!firstLaunch || !firstLaunch.intValue) return YES;
    else return NO;
}

- (void)setF_first_launch:(BOOL)f_first_launch
{
    if (f_first_launch) {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsFirstLaunch];
    }
    else
    {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsFirstLaunch];
    }
}

- (NSString *)f_time
{
    return [Account_UserDefaults objectForKey:kUserDefaultsTime] == nil ? @"" : [Account_UserDefaults objectForKey:kUserDefaultsTime];
}

- (void)setF_time:(NSString *)f_time
{
    [Account_UserDefaults setObject:f_time forKey:kUserDefaultsTime];
}

- (NSString *)f_accountID
{
    return [Account_UserDefaults objectForKey:kUserDefaultsAccountID] == nil ? @"" : [Account_UserDefaults objectForKey:kUserDefaultsAccountID];
}

- (void)setF_accountID:(NSString *)f_accountID
{
    [Account_UserDefaults setObject:f_accountID forKey:kUserDefaultsAccountID];
}

- (NSString *)f_userID
{
    return [Account_UserDefaults objectForKey:kUserDefaultsUserID];
}

- (void)setF_userID:(NSString *)f_userID
{
    [Account_UserDefaults setObject:f_userID forKey:kUserDefaultsUserID];

}

- (NSDictionary *)site
{
    return [Account_UserDefaults objectForKey:kUserDefaultsSite] == nil ? @"" : [Account_UserDefaults objectForKey:kUserDefaultsSite];
}

-(void)setSite:(NSDictionary *)site
{
    [Account_UserDefaults setObject:site forKey:kUserDefaultsSite];
}


- (BOOL)f_isLogined
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsIsLogined];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_isLogined:(BOOL)f_isLogined
{
    if (f_isLogined) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsIsLogined];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsIsLogined];
    }
}

- (NSString *)f_phoneNumber
{
    return [Account_UserDefaults objectForKey:kUserDefaultsPhoneNumber];
}

- (void)setF_phoneNumber:(NSString *)f_phoneNumber
{
    [Account_UserDefaults setObject:f_phoneNumber forKey:kUserDefaultsPhoneNumber];
}

- (NSString *)f_token
{
    return [Account_UserDefaults objectForKey:kUserDefaultsToken];
}

- (void)setF_token:(NSString *)f_token
{
    [Account_UserDefaults setObject:f_token forKey:kUserDefaultsToken];
}

- (NSString *)f_usedpoints
{
    return [Account_UserDefaults objectForKey:kUserDefaultsUsedpoints];
}

- (void)setF_usedpoints:(NSString *)f_usedpoints
{
    [Account_UserDefaults setObject:f_usedpoints forKey:kUserDefaultsUsedpoints];
}


-(NSString *)site_0_city
{
    return [Account_UserDefaults objectForKey:kUserDefaultsSite_0_City];
}

- (void)setSite_0_city:(NSString *)site_0_city
{
    [Account_UserDefaults setObject:site_0_city forKey:kUserDefaultsSite_0_City];
}

-(NSString *)site_1_district
{
    return [Account_UserDefaults objectForKey:kUserDefaultsSite_1_District];
}

- (void)setSite_1_district:(NSString *)site_1_district
{
    [Account_UserDefaults setObject:site_1_district forKey:kUserDefaultsSite_1_District];
}

-(NSString *)site_2_street
{
    return [Account_UserDefaults objectForKey:kUserDefaultsSite_2_Street];
}

- (void)setSite_2_street:(NSString *)site_2_street
{
    [Account_UserDefaults setObject:site_2_street forKey:kUserDefaultsSite_2_Street];
}

-(NSString *)site_3_depart
{
    return [Account_UserDefaults objectForKey:kUserDefaultsSite_3_Depart];
}

- (void)setSite_3_depart:(NSString *)site_3_depart
{
    [Account_UserDefaults setObject:site_3_depart forKey:kUserDefaultsSite_3_Depart];
}

- (NSString *)f_email
{
    return [Account_UserDefaults objectForKey:kUserDefaultsEmail];
}

- (void)setF_email:(NSString *)f_email
{
    [Account_UserDefaults setObject:f_email forKey:kUserDefaultsEmail];
}

- (BOOL)f_emailIsVerify
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsEmailIsVerify];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_emailIsVerify:(BOOL)f_emailIsVerify
{
    if (f_emailIsVerify) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsEmailIsVerify];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsEmailIsVerify];
    }
}

- (NSString *)f_nickName
{
    return [Account_UserDefaults objectForKey:kUserDefaultsNickName];
}

- (void)setF_nickName:(NSString *)f_nickName
{
    [Account_UserDefaults setObject:f_nickName forKey:kUserDefaultsNickName];
}

- (BOOL)f_isNickNameChange
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsIsNickNameChange];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_isNickNameChange:(BOOL)f_isNickNameChange
{
    if (f_isNickNameChange) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsIsNickNameChange];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsIsNickNameChange];
    }
}

- (NSString *)f_userIcon
{
    return [Account_UserDefaults objectForKey:kUserDefaultsUserIcon];
}

- (void)setF_userIcon:(NSString *)f_userIcon
{
    [Account_UserDefaults setObject:f_userIcon forKey:kUserDefaultsUserIcon];
}

- (BOOL)f_isSinaBinding
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsIsSinaBinding];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_isSinaBinding:(BOOL)f_isSinaBinding
{
    if (f_isSinaBinding) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsIsSinaBinding];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsIsSinaBinding];
    }
}

- (BOOL)f_isWechatBinding
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsIsWechatBinding];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_isWechatBinding:(BOOL)f_isWechatBinding
{
    if (f_isWechatBinding) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsIsWechatBinding];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsIsWechatBinding];
    }
}

- (BOOL)f_isQQBinding
{
    NSNumber *login = [Account_UserDefaults objectForKey:kUserDefaultsIsQQBinding];
    
    if (!login || !login.intValue) return NO;
    else return YES;
}

- (void)setF_isQQBinding:(BOOL)f_isQQBinding
{
    if (f_isQQBinding) {
        [Account_UserDefaults setObject:@1 forKey:kUserDefaultsIsQQBinding];
    }
    else
    {
        [Account_UserDefaults setObject:@0 forKey:kUserDefaultsIsQQBinding];
    }
}

@end

//
//  YLLAccountManager.h
//  yilule
//
//  Created by lidi on 15/6/9.
//  Copyright (c) 2015年 topview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLLAccountManager : NSObject

+ (instancetype)sharedAccountManager;

/**
 *  是否第一次安装
 */
@property(nonatomic,assign)BOOL      f_first_launch;

/**
 *  用户唯一标识
 */
@property(nonatomic,strong)NSString *f_accountID;

/**
 *  用户最后登录时间
 */
@property(nonatomic,strong)NSString *f_time;

/**
 *  巨坑，只是知道有些地方需要用到，暂不明白其作用
 */
@property(nonatomic,strong)NSString *f_userID;

/**
 *  是否登录状态
 */
@property(nonatomic,assign)BOOL f_isLogined;


/**
 *  存储使用过的地址
 */
@property(nonatomic,assign)NSDictionary *site;

/**
 *  用户绑定的手机号 如果为空 说明用户未绑定手机号
 */
@property(nonatomic,strong)NSString *f_phoneNumber;


/**
 *  用户token，每次登陆修改
 */
@property(nonatomic,strong)NSString *f_token;


/**
 *  用户积分
 */
@property(nonatomic,strong)NSString *f_usedpoints;


/**
 *  定位：城市ID
 */
@property(nonatomic,strong)NSString *site_0_city;

/**
 *  定位：地区ID
 */
@property(nonatomic,strong)NSString *site_1_district;

/**
 *  定位：街道ID
 */
@property(nonatomic,strong)NSString *site_2_street;

/**
 *  定位：小区ID
 */
@property(nonatomic,strong)NSString *site_3_depart;


/**
 *  用户绑定的邮箱
 */
@property(nonatomic,strong)NSString *f_email;

/**
 *  邮箱是否已经验证  0 未验证   1 已经验证
 */
@property(nonatomic,assign)BOOL f_emailIsVerify;

/**
 *  用户昵称
 */
@property(nonatomic,strong)NSString *f_nickName;

/**
 *  昵称是否修改过，主要用于小红点的逻辑判断 0 未修改  1 已经修改
 */
@property(nonatomic,assign)BOOL f_isNickNameChange;

/**
 *  用户头像地址
 */
@property(nonatomic,strong)NSString *f_userIcon;

/**
 *  是否绑定新浪微博帐户
 */
@property(nonatomic,assign)BOOL f_isSinaBinding;

/**
 *  是否绑定微信账号
 */
@property(nonatomic,assign)BOOL f_isWechatBinding;

/**
 *  是否绑定QQ账号
 */
@property(nonatomic,assign)BOOL f_isQQBinding;


@end

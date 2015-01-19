//
//  UPOMPBackStage.h
//  UnionPaySDK
//  后台支付类
//  Created by 翟尧 on 14-1-14.
//  Copyright (c) 2014年 翟 尧. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPOMPDelegate.h"

@interface UPOMPBackStage : NSObject

@property (nonatomic, assign) id<UPOMPDelegate> UPOMPDelegate;

/*
 实例化方法
 参数:
 1.ServerType 服务器类型 ServerProduct生产服务器 ServerTest测试服务器
 返回:UPOMPBackstage实例
 */
- (id)initWithServerType:(ServerType)serverType;

/*
 插件初始化
 参数:
 1.merchantId 商户id
 2.PaymentMode 支付模式 DefaultPayment支付模式 PreAuthorization预授权模式
 3.delegate 回调代理
 返回:无
 */
- (void)initUPOMPWithMerchantId:(NSString *)merchantId PaymentMode:(PaymentMode)paymentMode delegate:(id<UPOMPDelegate>)delegate;

/*
 订单支付
 参数:
 1.orderXML 订单信息
 2.userId 用户绑定id
 3.loginName 用户名
 4.bindId 银行卡绑定id
 5.imageCode 图形验证码
 6.smsCode 短信验证码
 7.delegate 回调代理
 返回:无
 */
- (void)UPOMPPaymentSubmitWithXML:(NSString *)orderXML UserId:(NSString *)userId LoginName:(NSString *)loginName BindId:(NSString *)bindId IMAGEcode:(NSString *)imageCode SMSCode:(NSString *)smsCode delegate:(id<UPOMPDelegate>)delegate;

/*
 获取卡列表
 参数:
 1.userId 用户绑定id
 2.loginName 用户名
 3.delegate 回调代理
 返回:无
 */
- (void)UPOMPGetCardListWithUserId:(NSString *)userId LoginName:(NSString *)loginName delegate:(id<UPOMPDelegate>)delegate;

/*
 获取短信验证码
 参数:
 1.bindId 银行卡绑定id
 2.delegate 回调代理
 返回:无
 */
- (void)UPOMPGetSMScodeWithBindId:(NSString *)bindId delegate:(id<UPOMPDelegate>)delegate;

/*
 获取图形验证码
 参数:无
 返回:无
 */
- (void)UPOMPGetIMAGEcodeWithdelegate:(id<UPOMPDelegate>)delegate;
@end

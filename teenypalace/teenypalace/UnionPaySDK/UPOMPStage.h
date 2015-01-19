//
//  UPOMPStage.h
//  UnionPaySDK
//  前台支付类
//  Created by 翟尧 on 14-1-14.
//  Copyright (c) 2014年 翟 尧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMPDelegate.h"

@interface UPOMPStage : UINavigationController

@property (nonatomic, assign) id<UPOMPDelegate> UPOMPDelegate;

/*
 支付启动接口。
 参数:
 1.xmlString 商户传递的参数报文
 2.PaymentMode 支付模式 DefaultPayment支付模式 PreAuthorization预授权模式
 3.ServerType 服务器类型 ServerProduct生产服务器 ServerTest测试服务器
 4.delegate 回调代理
 返回:id UPOMPStage实例
 */
- (id)initUPOMPPayWithXML:(NSString *)xmlString PaymentMode:(PaymentMode)paymentMode ServerType:(ServerType)serverType delegate:(id<UPOMPDelegate>)delegate;


/*
 单点登录、共用银行卡、实名认证三种验证方式启动接口。
 参数:
 1.xmlString 商户传递的参数报文
 2.VerificationMode 验证模式 DefaultMode普通模式 SingleSignOnMode单点登陆模式 BindCardMode银行卡绑定模式
 3.ServerType 服务器类型 ServerProduct生产服务器 ServerTest测试服务器
 4.delegate 回调代理
 返回:id UPOMPStage实例
 */
- (id)initUPOMPVerificationWithXML:(NSString *)xmlString VerificationMode:(VerificationMode)verificationMode ServerType:(ServerType)serverType delegate:(id<UPOMPDelegate>)delegate;

@end

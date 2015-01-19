//
//  UPOMPDelegate.h
//  UnionPaySDK
//  银联插件回调代理
//  Created by 翟 尧 on 13-3-27.
//  Copyright (c) 2013年 翟 尧. All rights reserved.
//

#import <UIKit/UIKit.h>

//服务器类型
typedef enum : NSInteger {
    ServerTest = 0,//测试服务器
    ServerProduct = 1//生产服务器
}ServerType;

//支付模式
typedef enum : NSInteger {
    DefaultPayment = 0,//支付
    PreAuthorization = 1//预授权
}PaymentMode;

//验证模式
typedef enum : NSInteger {
    SingleSignOnMode = 1,//单点登陆模式
    BindCardMode = 2//银行卡绑定模式
//    RealNameCertificationMode = 3//实名认证模式
}VerificationMode;

@protocol UPOMPDelegate <NSObject>
@required
/*
 关闭插件回调方法，由商户客户端实现。
 参数:1.xmlString 交易结束时传递的参数
 返回:无
 */
- (void)closeUPOMPWithXMLString:(NSString *)xmlString;




//以下为无UI支付回调方法
@optional
/*
 初始化成功（回调方法）
 参数:无
 返回:无
 */
- (void)UPOMPInitSuccess;

/*
 初始化失败（回调方法）
 参数:failDic 失败信息
 返回:无
 */
- (void)UPOMPInitFailed:(NSDictionary *)failDic;


/*
 获取银行卡成功（回调方法）
 参数:cardList 卡列表
 返回:无
 */
- (void)UPOMPGetCardListSuccess:(NSArray *)cardList;

/*
 获取银行卡失败（回调方法）
 参数:failDic 失败信息
 返回:无
 */
- (void)UPOMPGetCardListFailed:(NSDictionary *)failDic;

/*
 获取短信验证码成功（回调方法）
 参数:无
 返回:无
 */
- (void)UPOMPGetSMSCodeSuccess;

/*
 获取短信验证码失败（回调方法）
 参数:failDic 失败信息
 返回:无
 */
- (void)UPOMPGetSMSCodeFailed:(NSDictionary *)failDic;

/*
 获取图形验证码成功（回调方法）
 参数:无
 返回:无
 */
- (void)UPOMPGetIMAGECodeSuccess:(UIImage *)codeImage;

/*
 获取图形验证码失败（回调方法）
 参数:failDic 失败信息
 返回:无
 */
- (void)UPOMPGetIMAGECodeFailed:(NSDictionary *)failDic;

/*
 支付成功（回调方法）
 支付成功后会调用closeUPOMPWithXMLString“关闭插件回调方法”
 参数:无
 返回:无
 */
- (void)UPOMPPaySubmitSuccess;

/*
 支付失败（回调方法）
 参数:failDic 失败信息
 返回:无
 */
- (void)UPOMPPaySubmitFailed:(NSDictionary *)failDic;

/*
 服务器无返回值（回调方法）
 参数:无
 返回:无
 */
- (void)UPOMPServerFailed;

@end


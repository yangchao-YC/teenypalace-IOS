//
//  UPOMPGenerate.h
//  UnionPaySDK
//  UPOMP商户支付插件启动参数拼装类
//  Created by 翟 尧 on 13-4-23.
//  Copyright (c) 2013年 翟 尧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPOMPXMLGenerate : NSObject

/*
 拼装报文
 参数:1.bodayDic 报文正文
 返回:NSString 拼装好的xml报文
 */
+ (NSString *)generateXMLWithBodayDic:(NSDictionary *)bodayDic;

@end

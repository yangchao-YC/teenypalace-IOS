//
//  UPOMPXMLParser.h
//  UnionPaySDK
//  UPOMP商户支付插件关闭参数解析类
//  Created by 翟尧 on 12-10-15.
//  Copyright (c) 2012年 翟尧. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UPOMPXMLParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser *_parser;
    NSString *_rspStr;
    NSMutableString *_messStr;
    NSMutableDictionary *_infoDic;
    NSMutableDictionary *_listBank;//银行卡列表单个卡信息
    NSMutableArray *_listBankArray;//银行卡列表
}

/*
 解析插件回传的交易参数
 参数:1.xmlString 交易结束时传递的参数
 返回:NSMutableDictionary 参数字典
 */
- (NSMutableDictionary *)parserXML:(NSString *)xmlString;

@end

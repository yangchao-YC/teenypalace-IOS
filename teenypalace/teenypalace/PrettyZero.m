//
//  Doing.m
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "PrettyZero.h"

@interface PrettyZero()

@property (nonatomic,retain) NSMutableArray *date;

@end




@implementation PrettyZero


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect Screensize = [UIScreen mainScreen].bounds;
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screensize.size.width, Screensize.size.height - 99)];


        [self addSubview: self.webView];
        
        
        [self dateUrl];
        
    }
    return self;
}



/*
 mark:页数
 key:YES为下啦刷新   NO为加载更多
 */
-(void)dateUrl
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:DATE_PRETTY_INTRODUCE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.date = responseObject;
        [self dateHandle];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
}


/*
 数据处理
 */
-(void)dateHandle
{
    
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //获取本条数据

    //进行数据添加
    
    NSString * content = [NSString stringWithFormat:@"%@",[[self.date objectAtIndex:0] objectForKey:@"field_about_youthpalace_body"]];
    
    NSString *base = [NSString stringWithFormat:@"<base href=%@/>",DATE_URL];
    html = [html stringByReplacingOccurrencesOfString:@"{Base}" withString:base];
    html = [html stringByReplacingOccurrencesOfString:@"{Content}" withString:content];
    [self.webView loadHTMLString:html baseURL:baseURL];
    
}





@end

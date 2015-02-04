//
//  PrettyWebViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/2/4.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "PrettyWebViewController.h"

@interface PrettyWebViewController ()

@end

@implementation PrettyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[self.PrettyKey objectForKey:@"key"] intValue] == 1) {
        self.shareBtn.hidden = YES;
    }
    
    self.tabbarLabel.text = [self.PrettyKey objectForKey:@"title"];
    
    [self webViewDate];
    
}

-(void)webViewDate
{
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //获取本条数据
    
    
    NSString *date = [self.PrettyKey objectForKey:@"body"];
    
    //进行数据添加
    NSString *base = [NSString stringWithFormat:@"<base href=%@/>",DATE_URL];
    html = [html stringByReplacingOccurrencesOfString:@"{Base}" withString:base];
    
    html = [html stringByReplacingOccurrencesOfString:@"{Content}" withString:date];
    [self.webView loadHTMLString:html baseURL:baseURL];
}

-(IBAction)PrettyWebBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [self share];
            break;
    }
}

-(void)share
{
    NSString *text = [NSString stringWithFormat:@"武汉青少年宫活动。详情请点击%@%@",SHARE,[self.PrettyKey objectForKey:@"id"]];
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:nil
     shareText:text
     shareImage:nil
     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToEmail,UMShareToSina,UMShareToSms,UMShareToTencent ,nil]
     delegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

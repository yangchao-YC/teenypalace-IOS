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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SHARE_PRETTY,[self.PrettyKey objectForKey:@"id"]];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"武汉青少年宫";//设置微信好友标题
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"武汉青少年宫";//设置朋友圈标题
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;//设置好友链接
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;//设置朋友圈链接
    
    
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:nil
     shareText:[NSString stringWithFormat:@"武汉市青少年宫手机App应用是一款以引导广大青少年参加我宫素质教育和公益活动为核心内容的APP.详情请点击%@",url]
     shareImage:[UIImage imageNamed:@"share_image"]
     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSina,UMShareToSms,UMShareToTencent ,nil]
     delegate:nil];
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

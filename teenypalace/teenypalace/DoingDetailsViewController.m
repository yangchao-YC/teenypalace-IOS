//
//  DoingDetailsViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/6.
//  Copyright (c) 2014年 杨超. All rights reserved.
//


//活动详情页面


#import "DoingDetailsViewController.h"
#import "Masonry.h"
@interface DoingDetailsViewController ()

@end

@implementation DoingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = [self.doingKey objectForKey:@"field_charity_title"];//标题
    int time = [[self.doingKey objectForKey:@"eck_mobileapp_created"] intValue];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"1296035591  = %@",confromTimesp);
    
    NSString *times = [NSString stringWithFormat:@"发布时间：%@",confromTimesp];
    
    self.timeLabel.text = [times substringToIndex:15];//[self.doingKey objectForKey:@""];//发布时间
    self.checkSumLabel.text = [NSString stringWithFormat:@"点击数：%@",[self.doingKey objectForKey:@"field_charity_counter"]];//点击数
    
    NSString *eTime = [NSString stringWithFormat:@"%@-%@",[[self.doingKey objectForKey:@"field_charity_signup_starttime"]substringToIndex:10],[[self.doingKey objectForKey:@"field_charity_signup_endtime"]substringToIndex:10]];
    
    
    self.endTimeLabel.text = eTime;//时间周期
    self.startTimeLabel.text = [[self.doingKey objectForKey:@"field_charity_time"] substringToIndex:10];//开始时间
    self.addressLabel.text = [self.doingKey objectForKey:@"field_charity_address"];//地点
    self.phoneLabel.text = [self.doingKey objectForKey:@"field_charity_signup_tel"];//电话
    
    //self.contentLabel.text = [self.doingKey objectForKey:@"field_charity_introduction"];//内容
   // self.contentLabel.editable = NO;
   // self.contentLabel.hidden = YES;
   // self.contentLabel.textAlignment = NSTextAlignmentLeft;
   // self.contentLabel.contentInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
   // if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        
    //   self.automaticallyAdjustsScrollViewInsets = NO;
 
    //    }
    [self webViewDate];
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    if (app.DoingDetailsWebHidden) {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.webView.superview);
            
        }];
        
        self.Btn_Apply.hidden = YES;
        [self.webView layoutIfNeeded];
    }
    
    
    /*
    
    
    */
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",DATE_DOING_SUM,[self.doingKey objectForKey:@"id"]];
    
    [self dateUrl:urlString];
}


-(void)webViewDate
{
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //获取本条数据
    
    
    NSString *date = [self.doingKey objectForKey:@"field_charity_introduction"];
    
    //进行数据添加
    NSString *base = [NSString stringWithFormat:@"<base href=%@/>",DATE_URL];
    html = [html stringByReplacingOccurrencesOfString:@"{Base}" withString:base];
    
    html = [html stringByReplacingOccurrencesOfString:@"{Content}" withString:date];
    [self.webView loadHTMLString:html baseURL:baseURL];
}


-(void)dateUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}



/*
 tag
 0:返回
 1：分享
 2：报名
 3:电话
 */
-(IBAction)DoingDetailsBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [self share];
            break;
        case 2:
            [self doingApplyCheck];
            break;
        case 3:
            [self phone];
            break;
        default:
            
            break;
    }
}

-(void)doingApplyCheck
{
    [SVProgressHUD showWithStatus:@"正在查询活动最新信息..."];
    NSString *url = [NSString stringWithFormat:@"%@%@",DATE_DOING_APPLY_CHECK,[self.doingKey objectForKey:@"id"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            [SVProgressHUD dismiss];
            [self push];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:[responseObject objectForKey:@"message"] maskType:2];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}




-(void)push
{
    [self performSegueWithIdentifier:@"doingDetails_doingApply" sender:[self.doingKey objectForKey:@"id"]];
}


-(void)phone
{
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.doingKey objectForKey:@"field_charity_signup_tel"]]]];

    UIWebView *callWebView = [[UIWebView alloc]init];
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.doingKey objectForKey:@"field_charity_signup_tel"]]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [self.view addSubview:callWebView];
}

-(void)share
{
     NSString *url = [NSString stringWithFormat:@"%@%@",SHARE,[self.doingKey objectForKey:@"id"]];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"武汉青少年宫";//设置微信好友标题
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"武汉青少年宫";//设置朋友圈标题
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;//设置好友链接
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;//设置朋友圈链接
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:@"54ace3b6fd98c5ad2f000edb"
     shareText:[NSString stringWithFormat:@"武汉市青少年宫手机App应用是一款以引导广大青少年参加我宫素质教育和公益活动为核心内容的APP.详情请点击%@",url]
     shareImage:[UIImage imageNamed:@"share_image"]
     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSina,UMShareToSms,UMShareToTencent ,nil]
     delegate:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"doingApplyKey"];
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

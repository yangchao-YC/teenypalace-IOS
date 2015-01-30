//
//  DoingDetailsViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/6.
//  Copyright (c) 2014年 杨超. All rights reserved.
//


//活动详情页面


#import "DoingDetailsViewController.h"

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
    
    self.contentLabel.text = [self.doingKey objectForKey:@"field_charity_introduction"];//内容
    self.contentLabel.editable = NO;
   // self.contentLabel.textAlignment = NSTextAlignmentLeft;
   // self.contentLabel.contentInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
   // if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        
     //   self.automaticallyAdjustsScrollViewInsets = NO;
 
//    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",DATE_DOING_SUM,[self.doingKey objectForKey:@"id"]];
    
    [self dateUrl:urlString];
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
            [self performSegueWithIdentifier:@"doingDetails_doingApply" sender:[self.doingKey objectForKey:@"id"]];
            break;
        case 3:
            [self phone];
            break;
        default:
            
            break;
    }
}



-(void)phone
{
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.doingKey objectForKey:@"field_charity_signup_tel"]]]];
    
    NSLog(@"我被调用了");
    UIWebView *callWebView = [[UIWebView alloc]init];
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.doingKey objectForKey:@"field_charity_signup_tel"]]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telUrl]];
    [self.view addSubview:callWebView];
}

-(void)share
{
     NSString *text = [NSString stringWithFormat:@"武汉青少年宫活动。详情请点击%@%@",DATE_DOING_APPLY,[self.doingKey objectForKey:@"id"]];
    [UMSocialSnsService
     presentSnsIconSheetView:self
     appKey:nil
     shareText:text
     shareImage:nil
     shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToEmail,UMShareToSina,UMShareToSms,UMShareToTencent ,nil]
     delegate:self];
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

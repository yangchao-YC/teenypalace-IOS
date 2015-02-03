//
//  MessageWebViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//


//招生信息预览-老师详情页面

#import "MessageWebViewController.h"
#import "UIImageView+WebCache.h"
@interface MessageWebViewController ()

@end

@implementation MessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabbarLabel.text = [self.applyProfessionaKey objectForKey:@"field_teacher_name"];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@   %@",[self.applyProfessionaKey objectForKey:@"field_teacher_name"],[self.applyProfessionaKey objectForKey:@"field_teacher_class"]];
    
    [self.images setImageWithURL:[NSURL URLWithString:[self.applyProfessionaKey objectForKey:@"field_teacher_closeup"]]];
    
    
    [self webViewDate];
    
}

-(IBAction)messageWebBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)webViewDate
{
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //获取本条数据
    

    NSString *date = [self.applyProfessionaKey objectForKey:@"field_teacher_about_intro"];
    
    //进行数据添加

    html = [html stringByReplacingOccurrencesOfString:@"{Content}" withString:date];
    [self.webView loadHTMLString:html baseURL:baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

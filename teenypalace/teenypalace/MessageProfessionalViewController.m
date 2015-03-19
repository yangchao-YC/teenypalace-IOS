//
//  MessageProfessionalViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//招生信息预览-专业介绍

#import "MessageProfessionalViewController.h"

@interface MessageProfessionalViewController ()
{
    BOOL view0;
    BOOL view1;
    BOOL view2;
    BOOL view3;
    BOOL view4;
    int count;
}
@end

@implementation MessageProfessionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@",self.applyProfessionalKey);
    
    count = 1;
    view0 = YES;
    view1 = YES;
    view2 = YES;
    view3 = YES;
    view4 = YES;
    
    
    
    self.titleLabel.text = [self.applyProfessionalKey objectForKey:@"title"];
    
    CGRect ScreenSize = [UIScreen mainScreen].bounds;//获取屏幕尺寸
    
    self.scrollView.frame = CGRectMake(0, 40, ScreenSize.size.width, ScreenSize.size.height);
    
    
    
    
    //self.scrollView.showsHorizontalScrollIndicator = NO;
    //self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.directionalLockEnabled = YES;
    
    NSLayoutConstraint *widthView0 = [NSLayoutConstraint constraintWithItem:self.bgView0 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:ScreenSize.size.width - 10];
    [self.scrollView addConstraint:widthView0];
    
    
    
    NSLayoutConstraint *widthView2 = [NSLayoutConstraint constraintWithItem:self.bgView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:ScreenSize.size.width - 10];
    [self.scrollView addConstraint:widthView2];
    NSLayoutConstraint *widthView3 = [NSLayoutConstraint constraintWithItem:self.bgView3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:ScreenSize.size.width - 10];
    [self.scrollView addConstraint:widthView3];
    NSLayoutConstraint *widthView4 = [NSLayoutConstraint constraintWithItem:self.bgView4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:ScreenSize.size.width - 10];
    [self.scrollView addConstraint:widthView4];
    
    
    NSString *de = [NSString stringWithFormat:@"%@",[self.applyProfessionalKey objectForKey:@"zhuanye_level_description"]];
    NSString *intr = [NSString stringWithFormat:@"%@",[self.applyProfessionalKey objectForKey:@"zhanye_teacher_intro"]];
    NSString *zp = [NSString stringWithFormat:@"%@",[self.applyProfessionalKey objectForKey:@"zhanye_student_zp"]];
    NSString *fc = [NSString stringWithFormat:@"%@",[self.applyProfessionalKey objectForKey:@"zhanye_student_fc"]];
    
    
    [self state:de View:self.bgView1 NSLayoutConstraint:self.viewHeight1 WebView:self.viewWeb1];
    [self state:intr View:self.bgView2 NSLayoutConstraint:self.viewHeight2 WebView:self.viewWeb2];
    [self state:zp View:self.bgView3 NSLayoutConstraint:self.viewHeight3 WebView:self.viewWeb3];
    [self state:fc View:self.bgView4 NSLayoutConstraint:self.viewHeight4 WebView:self.viewWeb4];

    
    
    [self webViewDate:self.viewWeb0 Key:[self.applyProfessionalKey objectForKey:@"description"]];
    
    int height = ScreenSize.size.height - 104;//104为scroll所在上边距
    
    if (height< (count *205 + 40)) {
        self.scrollView.contentSize = CGSizeMake(0,(count *205) + 50);
    }
    else
    {
        self.scrollView.contentSize = CGSizeMake(0,height);
    }
    
}


/*
 string:匹配字符
 ViewS：需被添加约束的View
 Layout：需更改的约束
 webView：需赋值的webview
 */
-(void)state:(NSString *)string View:(UIView *)ViewS NSLayoutConstraint:(NSLayoutConstraint *)Layout WebView:(UIWebView *)webView
{
    CGRect ScreenSize = [UIScreen mainScreen].bounds;//获取屏幕尺寸
    
    if ([string isEqualToString:@"<null>"]) {
        Layout.constant = 0;
        ViewS.hidden = YES;
        
    }
    else
    {
        NSLayoutConstraint *widthView1 = [NSLayoutConstraint constraintWithItem:ViewS attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:ScreenSize.size.width - 10];
        [self.scrollView addConstraint:widthView1];
        
        [self webViewDate:webView Key:string];
        
        count +=1;
        
    }
}


/*
 0：返回
 1：返回根目录
 11：专业查看按钮
 12：层次查看按钮
 13：主讲教师按钮
 14：学员作品按钮
 15：学员风采按钮
 */

-(IBAction)MessageProfessionalBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 2:
            [self performSegueWithIdentifier:@"messageProfessional_applyLevel" sender:[self.applyProfessionalKey objectForKey:@"id"]];
            break;
        case 11:
            if (view0) {
                self.viewHeight0.constant = 200;
                view0 = NO;
            }
            else
            {
                self.viewHeight0.constant = 50;
                view0 = YES;
            }
            break;
        case 12:
            if (view1) {
                self.viewHeight1.constant = 200;
                view1 = NO;
            }
            else
            {
                self.viewHeight1.constant = 50;
                view1 = YES;
            }
            break;
        case 13:
            if (view2) {
                self.viewHeight2.constant = 200;
                view2 = NO;
            }
            else
            {
                self.viewHeight2.constant = 50;
                view2 = YES;
            }
            break;
        case 14:
            if (view3) {
                self.viewHeight3.constant = 200;
                view3 = NO;
            }
            else
            {
                self.viewHeight3.constant = 50;
                view3 = YES;
            }
            break;
        case 15:
            if (view4) {
                self.viewHeight4.constant = 200;
                view4 = NO;
            }
            else
            {
                self.viewHeight4.constant = 50;
                view4 = YES;
            }
            break;
        default:
            
            break;
    }
}


-(void)webViewDate:(UIWebView *)webView Key:(NSString *)key
{
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //获取本条数据

    
    //进行数据添加
    NSString *base = [NSString stringWithFormat:@"<base href=%@/>",DATE_URL];
    html = [html stringByReplacingOccurrencesOfString:@"{Base}" withString:base];
    html = [html stringByReplacingOccurrencesOfString:@"{Content}" withString:key];
    [webView loadHTMLString:html baseURL:baseURL];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"applyProfessionalKey"];
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

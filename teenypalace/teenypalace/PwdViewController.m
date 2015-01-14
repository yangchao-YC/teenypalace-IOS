//
//  PwdViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/1/8.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

//设置密码

#import "PwdViewController.h"

@interface PwdViewController ()
{
      BOOL checkBox ;//是否显示密码
}

@property(nonatomic,retain)NSDictionary *dic;


@end

@implementation PwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    checkBox = NO;
    self.pwdBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_check_false"]];
    
    NSLog(@"%@",[self.pwdKey objectForKey:@"key"]);
    
    NSLog(@"%@",[self.pwdKey objectForKey:@"phone"]);
    
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
}


-(void)dateUrl:(NSString *)url
{
    [SVProgressHUD showWithStatus:@"正在申请验证码" maskType:2];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dic = responseObject;

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络异常，请稍后再试" maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
}



-(IBAction)pwdBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            if (checkBox) {
                checkBox = NO;
                [self.pwdOneTextField setSecureTextEntry:YES];//设置密码框
                [self.pwdTwoTextField setSecureTextEntry:YES];//设置密码框
                self.pwdBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_check_false"]];
            }
            else
            {
                checkBox = YES;
                [self.pwdOneTextField setSecureTextEntry:NO];//设置密码框
                [self.pwdTwoTextField setSecureTextEntry:NO];//设置密码框
                self.pwdBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_check_true"]];
            }
            break;
        case 2:
             [self dismissModalViewControllerAnimated:YES];//关闭Login系列界面
            break;
        default:
            break;
    }
}



//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

//关闭键盘
- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

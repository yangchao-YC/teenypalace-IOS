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

    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
}




/*
 0:返回
 1：设置是否显示密码
 2：确定
 */


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
            [self okBtn];
            break;
        default:
            break;
    }
}

/*
 确定按钮触发
 */
-(void)okBtn
{
    NSString *onePwd;
    NSString *twoPwd;
   
    onePwd = [self.pwdOneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    twoPwd = [self.pwdTwoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (onePwd.length>5) {
        if ([onePwd isEqualToString:twoPwd]) {
            NSString *urlString;
            
            if([[self.pwdKey objectForKey:@"key"] isEqualToString:@"1"])//1为注册   0为修改密码
            {
                urlString = [NSString stringWithFormat:@"%@%@/verifycode/%@/password/%@",DATE_REGISTER_SET_PWD,[self.pwdKey objectForKey:@"phone"],[self.pwdKey objectForKey:@"verifycode"],onePwd];
            }
            else
            {
                urlString = [NSString stringWithFormat:@"%@%@/%@/%@",DATE_FYCODE_SET_PWD,[self.pwdKey objectForKey:@"phone"],[self.pwdKey objectForKey:@"verifycode"],onePwd];
            }
            
            
            [SVProgressHUD showWithStatus:@"正在设置密码"];
            [self dateUrl:urlString];
 
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"2次密码不一致" maskType:2];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"密码长度小于6位" maskType:2];
    }

}



-(void)dateUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dic = responseObject;
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
    if ([[self.dic objectForKey:@"status"]intValue] == 0) {//密码设置成功
        [SVProgressHUD showSuccessWithStatus:@"密码设置成功" maskType:2];
        
       // AppDelegate *app = [[UIApplication sharedApplication]delegate];
        
        YLLAccountManager *accountManager = [YLLAccountManager sharedAccountManager];
        accountManager.f_isLogined = YES;//登陆成功
        accountManager.f_phoneNumber = [self.pwdKey objectForKey:@"phone"];//存储账号
        accountManager.f_userID = [self.dic objectForKey:@"parentid"];//存储家长ID
        accountManager.f_time = [self.dic objectForKey:@"lastlogintime"];//存储最后登陆时间
        
        
//        app.UserName = [self.pwdKey objectForKey:@"phone"];//存储账号
//        app.ParentId = [self.dic objectForKey:@"parentid"];//存储家长ID
//        app.LastloginTime = [self.dic objectForKey:@"lastlogintime"];//存储最后登陆时间
//        app.Login = true;//更改登陆状态

        
        [self dismissModalViewControllerAnimated:YES];//关闭Login系列界面
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:2];
        [self.navigationController popViewControllerAnimated:YES];
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

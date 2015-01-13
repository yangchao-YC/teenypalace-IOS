//
//  LoginViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/5.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"

/*
 checkBox:是否记住密码
 pwdToken:token密码
 TokenPwd:执行使用token登陆   1.YES   2.NO
 
 */


@interface LoginViewController ()
{
    BOOL checkBox ;
    NSString *pwdToken;//token密码
    BOOL TokenPwd;//执行使用token登陆
}


@property (nonatomic,retain)NSDictionary *articles;

@end

@implementation LoginViewController



+ (void)logOut
{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationViewController = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"LoginNav"];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:navigationViewController animated:YES completion:^{
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TokenPwd = NO;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *check = [user stringForKey:@"check"];
    NSString *userName = [user stringForKey:@"user"];
    NSString *loginOK = [user stringForKey:@"loginOK"];//上次是否登陆成功
    
    
    if([check isEqual:@"1"] )//判断是否记住密码
    {
        checkBox = true;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_true"];
    }
    else
    {
        checkBox = false;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_false"];
    }
    
    if([check isEqual:@"1"] && [loginOK isEqual:@"1"]) {//判断是否记住了密码
        
        pwdToken = [NSString stringWithFormat:@"%@",[user stringForKey:@"token"]];
        TokenPwd = YES;
        self.pwdTextField.text = @"123456";
        
    }
    if(userName.length !=0)//上次登陆成功则将登录框信息填充
    {
        self.nameTextField.text = userName;
    }


    self.CheckImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkBoxs)];
    [self.CheckImage addGestureRecognizer:singleTap];

    [self.pwdTextField setSecureTextEntry:YES];//设置密码框

    self.nameTextField.returnKeyType = UIReturnKeyNext;
    self.pwdTextField.returnKeyType = UIReturnKeyDefault;
    
    self.nameTextField.clearsOnBeginEditing = YES;//再次编辑清空
    self.pwdTextField.clearsOnBeginEditing = YES;
    
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

}



/*

 tag:
 0.忘记密码
 1.登陆
 2.注册新用户
 3.跳过
 
 */
 -(IBAction)btnLogin:(UIButton *)sender
 {
    switch (sender.tag) {
 
        case 0:
            [self performSegueWithIdentifier:@"login_InformationProcessing" sender:@"0"];
            break;
        case 1:
            if (TokenPwd) {//执行token登陆
                NSString *url = [NSString stringWithFormat:@"%@%@",DATE_LOGIN_TOKEN,pwdToken];
                [self dateUrl:url];
            }
            else
            {
                [self login];
            }
            break;
        case 2:
            [self performSegueWithIdentifier:@"login_InformationProcessing" sender:@"1"];
            break;
        case 3:
            [self dismissModalViewControllerAnimated:YES];
             break;
        case 4:
            break;
        default:
            break;
    }
 }





-(void)login
{
    NSString *user;
    NSString *pwd;
    user = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pwd= [self.pwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (user.length == 11) {//判断手机号长度
        if (pwd.length >5) {//判断时候输入密码
            NSString *url = [NSString stringWithFormat:@"%@%@/password/%@",DATE_LOGIN,user,pwd];
            [self dateUrl:url];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"密码长度不对" maskType:2];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码" maskType:2];
    }
    
   
}


-(void)dateUrl:(NSString *)url
{
    [SVProgressHUD showWithStatus:@"正在登陆"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = responseObject;
        
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
           
             NSLog(@"登陆成功");
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            
            app.UserName = self.nameTextField.text;//存储账号
            app.ParentId = [responseObject objectForKey:@"parentid"];//存储家长ID
            app.LastloginTime = [responseObject objectForKey:@"lastlogintime"];//存储最后登陆时间
            app.Login = true;//更改登陆状态
            
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:self.nameTextField.text forKey:@"user"];//存储账号到本地
            [user setObject:@"1" forKey:@"loginOK"];//登陆成功
            if (checkBox) {
                [user setObject:[responseObject objectForKey:@"token"] forKey:@"token"];//存储token到本地
            }
            
            [SVProgressHUD showSuccessWithStatus:@"登陆成功" maskType:2];
            
            [self dismissModalViewControllerAnimated:YES];
            
        }
        else
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"0" forKey:@"loginOK"];//登陆成功
            [SVProgressHUD showInfoWithStatus:[responseObject objectForKey:@"message"] maskType:2];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络异常，请稍后再试" maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
    
}




-(void)checkBoxs
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (checkBox) {
        checkBox = false;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_false"];
        [user setObject:@"0" forKey:@"check"];//存储是否记住密码
    }
    else
    {
        checkBox = true;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_true"];
        [user setObject:@"1" forKey:@"check"];//存储是否记住密码
    }
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        self.pwdTextField.text = nil;
    }
    
    TokenPwd = NO;//不使用token登陆
}


//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}
//设置用户名只能输入数字并且不能大于11位字符长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    
    // Check for non-numeric characters
    if (textField == self.nameTextField) {
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        // Check for total length
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 11) return NO;//限制长度
        return YES;
    }
    else
    {
        return YES;
    }
}
//关闭键盘
- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];  
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"InformationProcessingKey"];
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

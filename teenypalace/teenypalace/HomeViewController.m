//
//  HomeViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    BOOL checkBox ;
    CGRect ScreenSize;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //首先应该检查是否登录了。没登录就弹出登录界面
   // [self performSelector:@selector(gotoLogin) withObject:self afterDelay:.1f];
    
    ScreenSize = [UIScreen mainScreen].bounds;

   // NSLog(@"%f",cc.size.width);//获取屏幕宽度
    
    checkBox = false;
    self.CheckImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkBoxs)];
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    [self.CheckImage addGestureRecognizer:singleTap];
    
    self.nameTextField.delegate = self;
    self.pwdTextField.delegate = self;
    
    [self.pwdTextField setSecureTextEntry:YES];//设置密码框
    
    
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    self.pwdTextField.returnKeyType = UIReturnKeyDefault;
   
}


/*
 tag:
 0.忘记密码
 1.登陆
 2.注册新用户
 3.跳过
 */

-(IBAction)btnHome:(UIButton *)sender
{
    switch (sender.tag) {
            
        case 0:
            NSLog(@"0");
            break;
        case 1:
           // [self dismissModalViewControllerAnimated:YES];
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            
            [self loginHide];
            
            NSLog(@"3");
            break;
        
        case 4:
            [self loginShow];
            break;
        default:
            break;
    }
}




-(void)loginHide
{
    [UIView animateWithDuration:1 animations:^{
        self.loginView.frame = CGRectMake(-(ScreenSize.size.width), 0, ScreenSize.size.width, ScreenSize.size.height);
    }];
}

-(void)loginShow
{
    [UIView animateWithDuration:1 animations:^{
        self.loginView.frame = CGRectMake(0, 0, ScreenSize.size.width, ScreenSize.size.height);
    }];
}


-(void)checkBoxs
{
    if (checkBox) {
        checkBox = false;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_false"];
    }
    else
    {
        checkBox = true;
        self.CheckImage.image = [UIImage imageNamed:@"login_check_true"];
    }
}


/*
- (void)gotoLogin
{
    
    [self.navigationController performSegueWithIdentifier:@"HomeToLoginSegue" sender:self];
}
 */


//开始编辑输入框的时候，软键盘出现，执行此事件

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +32 - (self.view.frame.size.height - 216.0);
    //  NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if (offset > 0) {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}


//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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

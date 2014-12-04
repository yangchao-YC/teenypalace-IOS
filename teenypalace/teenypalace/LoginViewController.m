//
//  LoginViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/5.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    BOOL checkBox ;
}
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
    
    
    
    checkBox = false;
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
            NSLog(@"0");
            break;
        case 1:
            [self dismissModalViewControllerAnimated:YES];
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            [self dismissModalViewControllerAnimated:YES];
            //  [self loginHide];
 
            NSLog(@"3");
            break;
 
        case 4:
            //  [self loginShow];
            break;
        default:
            break;
    }
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

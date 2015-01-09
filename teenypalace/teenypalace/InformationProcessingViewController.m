//
//  InformationProcessingViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/1/8.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

//信息处理，账号注册，忘记密码

#import "InformationProcessingViewController.h"

@interface InformationProcessingViewController ()

@end

@implementation InformationProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timeStart = YES;
    
    NSLog(@"aa%@",self.InformationProcessingKey);//0为忘记密码，1为注册
    
    if ([self.InformationProcessingKey isEqualToString:@"1"]) {
        self.tabbarLabel.text = @"注册新用户";
    }
    
    self.identifyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ok_btn"]];
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
}



/*tag
 0.返回
 1.获取验证码
 2.下一步
*/
-(IBAction)InformationProcessingBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            if (timeStart) {//判断时候启动定时器
                timeStart = NO;
                [self Time];
            }
            break;
        case 2:
           [self performSegueWithIdentifier:@"InformationProcessing_pwd" sender:@"1"];
            break;
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
    
}

//开始获取验证码，准备开始计时
-(void)Time
{
    
    self.identifyBtn.backgroundColor = [UIColor grayColor];
    time = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
    [self.identifyBtn setTitle:@"重新获取(60秒)" forState:UIControlStateNormal];
}
/*
 开始计时
 */
-(void)startTimer
{
    time--;
    NSString *date = [NSString stringWithFormat:@"重新获取(%d秒)",time];
    
    [self.identifyBtn setTitle:date forState:UIControlStateNormal];
    if (time == -1) {
        [self stopTimer];
    }
}
/*
 暂停计时
 */
-(void)stopTimer
{
    [timer setFireDate:[NSDate distantFuture]];
    self.identifyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ok_btn"]];
    [self.identifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    timeStart = YES;
    
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
    if (textField == self.phoneTextField) {
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
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        // Check for total length
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 4) return NO;//限制长度
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
    [push setValue:sender forKey:@"pwdKey"];
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

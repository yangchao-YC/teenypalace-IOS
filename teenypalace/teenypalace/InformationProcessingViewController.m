//
//  InformationProcessingViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/1/8.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

//信息处理，账号注册，忘记密码

#import "InformationProcessingViewController.h"
#import<CommonCrypto/CommonDigest.h>

@interface InformationProcessingViewController ()
{
    NSString *verifycode;//验证码
    NSString *phone;//验证账号
}
@property(nonatomic,retain)NSDictionary *dic;
@end


@implementation InformationProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timeStart = YES;
    
   // NSLog(@"aa%@",self.InformationProcessingKey);//0为忘记密码，1为注册
    
    
    verifycode = @"";
    
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
            [self identifyCheCk];
            break;
        case 2:
            [self next];
            break;
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
    
}

/*
下一步
 */
-(void)next
{
   
    NSString *identify;
    identify = [self.identifyTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
     NSLog(@"identify    %@",identify);
    NSLog(@"verifycode    %@",verifycode);
    if (identify.length == 4) {
        if ([identify intValue] == [verifycode intValue]) {
            NSLog(@"匹配成功");
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:verifycode,@"verifycode",phone,@"phone",@"1",@"key", nil];
 
            [self performSegueWithIdentifier:@"InformationProcessing_pwd" sender:dic];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"验证码不正确" maskType:2];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"验证码长度不对" maskType:2];
    }

}

/*
 获取验证码
 */
-(void)identifyCheCk
{
    NSString *phoneString;
    phoneString = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (phoneString.length == 11) {//判断号码长度时候正确
        
        if (timeStart) {//判断时候启动定时器

            timeStart = NO;
            
            [self Time];
            
            if ([self.InformationProcessingKey isEqualToString:@"1"]) {
                NSString *MD5 =[self md5HexDigest:[self md5HexDigest:[NSString stringWithFormat:@"%@%@",phoneString,DATE_REGISTER_MD5]]];
                NSString *url = [NSString stringWithFormat:@"%@%@/%@",DATE_REGISTER_IDENTIFY,phoneString,MD5];
                [self dateUrl:url Key:1];
            }
            else
            {
                NSString *url = [NSString stringWithFormat:@"%@%@",DATE_FYCODE_IDENTIFY,phoneString];
                [self dateUrl:url Key:0];
            }
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码" maskType:2];//提示手机号码错误
    }
}

/*
 注册用验证码验证
 */
-(void)RidentifyHandle
{
    if ([[ self.dic objectForKey:@"status"]intValue] == 0) {//请求发送成功
        [SVProgressHUD showSuccessWithStatus:@"已发送请求" maskType:2];
        verifycode = [self.dic objectForKey:@"verifycode"];//存储验证码
        phone = [self.dic objectForKey:@"phone"];//存储账号
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:2];
    }
}
/*
 修改密码验证码验证
 */
-(void)PidentifyHandle
{
    
}


-(void)dateUrl:(NSString *)url Key:(int)key
{
    [SVProgressHUD showWithStatus:@"正在申请验证码" maskType:2];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dic = responseObject;
        if (key == 1) {
            [self RidentifyHandle];//调用注册验证
        }
        else
        {
            [self PidentifyHandle];//调用修改密码验证
        }
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络异常，请稍后再试" maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
  
}



/*
 MD5加密
 */
- (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
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

//
//  DoingApplyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/8.
//  Copyright (c) 2014年 杨超. All rights reserved.
//活动报名页面

#import "DoingApplyViewController.h"

@interface DoingApplyViewController ()

@end

@implementation DoingApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    self.phoneTextField.returnKeyType = UIReturnKeyNext;
    self.phoneTwoTextField.returnKeyType = UIReturnKeyNext;
    self.siteTextField.returnKeyType = UIReturnKeyDefault;
    
    self.nameTextField.clearsOnBeginEditing = YES;//再次编辑清空
    self.phoneTextField.clearsOnBeginEditing = YES;//再次编辑清空

    
    
    
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
}




/*
 报名
 card：学员卡号
 classID：班级ID
 */
-(void)datePost:(NSString *)name Phone:(NSString *)phone1 Phone2:(NSString *)phone2 Addres:(NSString *)addres
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    /*
     field_charitysignup_username        姓名
     field_charitysignup_contactinfo1    联系方式一
     field_charitysignup_contactinfo2    联系方式二
     field_charitysignup_address         地址
     field_charitysignup_charityid       活动ID
     */
    
    NSLog(@"%@-%@-%@-%@-%@-%@",name,phone1,phone2,addres,self.doingApplyKey,DATE_DOING_APPLY);
    [requestManager POST:DATE_DOING_APPLY parameters:
     @{@"field_charitysignup_username":name,
       @"field_charitysignup_contactinfo1":phone1,
       @"field_charitysignup_contactinfo2":phone2,
       @"field_charitysignup_address":addres,
       @"field_charitysignup_charityid":self.doingApplyKey
       }success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"JSON: %@", responseObject);
           
           NSDictionary *dic = responseObject;
           if ([[dic objectForKey:@"status"] intValue] == 0) {
               [SVProgressHUD showSuccessWithStatus:@"报名成功" maskType:3];
               [self.navigationController popViewControllerAnimated:YES];
           }
           else{
               [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"message"] maskType:3];
           }
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
           NSString *errorString = [NSString stringWithFormat:@"%@",error];
           [SVProgressHUD showInfoWithStatus:errorString maskType:3];//异常提示
       }];
}



-(IBAction)DoingApplyBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [self apply];
            break;
        default:
            break;
    }
    
}

-(void)apply
{
    NSString *name;
    NSString *phone1;
    NSString *phone2;
    NSString *address;
    
    name = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    phone1 = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    phone2 = [self.phoneTwoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    address = [self.siteTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (name.length >0) {
        if (phone1.length == 11) {
            if (phone2.length !=0) {
                if (phone2.length ==11) {
                    if (address.length !=0) {
                        
                        [SVProgressHUD showInfoWithStatus:@"正在报名,请稍后" maskType:3];
                        [self datePost:name Phone:phone1 Phone2:phone2 Addres:address];
                    }
                    else
                    {
                        address = @"";
                        [SVProgressHUD showInfoWithStatus:@"正在报名,请稍后" maskType:3];
                        [self datePost:name Phone:phone1 Phone2:phone2 Addres:address];
                    }
                }
                else
                {
                    [SVProgressHUD showInfoWithStatus:@"联系方式必须为11位手机号码" maskType:3];
                }
            }
            else
            {
                if (address.length !=0) {
                    [SVProgressHUD showInfoWithStatus:@"正在报名,请稍后" maskType:3];
                    [self datePost:name Phone:phone1 Phone2:phone2 Addres:address];
                }
                else
                {
                    address = @"";
                    [SVProgressHUD showInfoWithStatus:@"正在报名,请稍后" maskType:3];
                    [self datePost:name Phone:phone1 Phone2:phone2 Addres:address];
                }
                
            }
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"联系方式必须为11位手机号码" maskType:3];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"姓名不能为空" maskType:3];
    }
    
}




//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        [self.phoneTextField becomeFirstResponder];//使下一个联系方式对话框获取焦点
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
//设置用户名只能输入数字并且不能大于11位字符长度
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    // Check for non-numeric characters
    if (textField == self.phoneTextField  || textField == self.phoneTwoTextField) {
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

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






-(IBAction)DoingApplyBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

//
//  MyNewCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/26.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "MyNewCardViewController.h"

@interface MyNewCardViewController ()
{
    int sex;//0为男，1为女
}
@end

@implementation MyNewCardViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sex = 0;
    
    if ([self.MyNewKey isEqualToString:@"1"]) {
        self.sexLabel.hidden = YES;
        self.sexView.hidden = YES;
        self.dateBtn.hidden = YES;
        self.dateLabel.hidden = YES;
        self.cardTextField.placeholder = @"请输入卡号：";
        NSLayoutConstraint *topOK = [NSLayoutConstraint constraintWithItem:self.okBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sexView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
        [self.bgView addConstraint:topOK];
    }
    
    
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    
}



/*
 tag
 0:返回
 1：男
 2：女
 3：出生日期
 4：确定
 */

-(IBAction)MyCardNewBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            self.manImage.image = [UIImage imageNamed:@"radio_true"];
            self.womanImage.image = [UIImage imageNamed:@"radio_false"];
            sex = 0;
            break;
        case 2:
            self.manImage.image = [UIImage imageNamed:@"radio_false"];
            self.womanImage.image = [UIImage imageNamed:@"radio_true"];
            sex = 1;
            break;
        case 3:
            
            break;
        case 4:
            
            break;
    }
    
    NSLog(@"%d",sex);
}

//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.nameTextField) {
        [self.cardTextField becomeFirstResponder];//使下一个联系方式对话框获取焦点
    }
    else
    {
    
    [textField resignFirstResponder];
    }
    return YES;
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

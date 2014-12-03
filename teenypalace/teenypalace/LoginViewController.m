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
    
}

/*
 tag:
 0.记住密码
 1.忘记密码
 2.登陆
 3.注册新用户
 */
-(IBAction)btnLogin:(UIButton *)sender
{
    switch (sender.tag) {

        case 1:
            [self dismissModalViewControllerAnimated:YES];
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
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

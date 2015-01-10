//
//  HomeViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//



//主页面


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
    
    [self performSelector:@selector(logout) withObject:self afterDelay:.5f];

    // ScreenSize = [UIScreen mainScreen].bounds;//获取屏幕尺寸

}

//这个方法只弹出登录界面
- (void)logout
{
    [LoginViewController logOut];
}



- (void)gotoLogin
{
    [self.navigationController performSegueWithIdentifier:@"LoginNav" sender:self];
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

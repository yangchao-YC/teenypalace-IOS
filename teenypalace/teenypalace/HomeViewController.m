//
//  HomeViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //首先应该检查是否登录了。没登录就弹出登录界面
    [self performSelector:@selector(gotoLogin) withObject:self afterDelay:.1f];
}

- (void)gotoLogin
{
    [self.navigationController performSegueWithIdentifier:@"HomeToLoginSegue" sender:self];
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

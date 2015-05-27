//
//  DoingDetailsViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/6.
//  Copyright (c) 2014年 杨超. All rights reserved.
//


//活动详情页面


#import "DoingceshiViewController.h"

@interface DoingceshiViewController ()

@end

@implementation DoingceshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/*
 tag
 0:返回
 1：分享
 2：报名
 3:电话
 */
-(IBAction)DoingDetailsBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            break;
        case 2:
            [self performSegueWithIdentifier:@"kaishiceshi" sender:[self.doingKey objectForKey:@"id"]];
            break;
        case 3:
            break;
        default:
            
            break;
    }
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"Key"];
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

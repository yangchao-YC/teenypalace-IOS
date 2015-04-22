//
//  DoingCeremonyViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/3/24.
//  Copyright (c) 2015年 杨超. All rights reserved.


//活动-祭奠活动

#import "DoingCeremonyViewController.h"

@interface DoingCeremonyViewController ()

@end

@implementation DoingCeremonyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.doingKey);
}





-(IBAction)DoingCeremonyBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"doingApplyKey"];
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

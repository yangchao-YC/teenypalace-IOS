//
//  DoingCommentViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/3/24.
//  Copyright (c) 2015年 杨超. All rights reserved.


//活动-评论页面

#import "DoingCommentViewController.h"

@interface DoingCommentViewController ()

@end

@implementation DoingCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"进入评论页面");
    
    
}





-(IBAction)DoingCommentBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 2:
            [self pushComment];
            break;
        default:
            break;
    }
}


-(void)pushComment
{
    NSString *content= self.contentTextView.text;
    
    
    
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

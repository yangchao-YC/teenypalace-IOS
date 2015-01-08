//
//  MySiteViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//用户中心-设置

#import "MySiteViewController.h"
#import "MobClick.h"
@interface MySiteViewController ()
{
    NSDictionary *version;
}
@property(nonatomic,strong)UIAlertView *alert;
@end

@implementation MySiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(IBAction)MySiteBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [MobClick checkUpdateWithDelegate:self selector:@selector(Update:)];
            break;
    }
}

-(void)Update:(NSDictionary *)info
{
    

    version = info;
    
    NSLog(@"%@",info);
    NSString *update = [NSString stringWithFormat:@"%@",[version objectForKey:@"update"]];
    if ([update isEqualToString:@"NO"]) {
        _alert = [[UIAlertView alloc]initWithTitle:@"当前版本是最新" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_alert show];
    }
    else if([update isEqualToString:@"YES"])
    {
        NSString *title = [NSString stringWithFormat:@"有可用的新版本%@",[version objectForKey:@"version"]];
        NSString *message = [NSString stringWithFormat:@"%@",[version objectForKey:@"update_log"]];
        
        _alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"忽略此版本" otherButtonTitles:@"访问 Store",nil];
        [_alert show];
        
    }
    else
    {
        _alert = [[UIAlertView alloc]initWithTitle:@"超时，请稍后再试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_alert show];
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

//
//  ApplyClassDetailsViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//在线报名-班级详情页面

#import "ApplyClassDetailsViewController.h"

@interface ApplyClassDetailsViewController ()

@property (nonatomic,retain) NSDictionary *dic;

@property (nonatomic,strong)ApplyAlertView *alertView ;

@end

@implementation ApplyClassDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@",self.applyDetailsKey);
   
    self.classNameLabel.text = [NSString stringWithFormat:@"班级名称：%@",[self.applyDetailsKey objectForKey:@"classname"]];
    
    self.timeLabel.text = [self.applyDetailsKey objectForKey:@"learnaddress"];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"学费：%@",[self.applyDetailsKey objectForKey:@"tuition"]];
    [SVProgressHUD showInfoWithStatus:LOADING];
    
    
    NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_CLASS_DETAILS,
                      [self.applyDetailsKey objectForKey:@"classid"]];
    
    [self dateUrl:date];
    
}



-(void)dateUrl:(NSString *)url
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dic = responseObject;
        dispatch_async(dispatch_get_main_queue(), ^{//脱离异步线程，在主线程中执行
            [self dateHandle];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
    
}
/*
 数据处理
 */
-(void)dateHandle
{
    [SVProgressHUD dismiss];
    
    self.countTimeLabel.text = [NSString stringWithFormat:@"总课时：%@",[self.dic objectForKey:@"zongkeshi"]];
    self.yearLabel.text = [NSString stringWithFormat:@"年份：%@",[self.dic objectForKey:@"year"]];
    self.quarterlyLabel.text = [NSString stringWithFormat:@"季度：%@",[self.dic objectForKey:@"jidu"]];
    self.ageSLabel.text = [NSString stringWithFormat:@"开班时间开始：%@",[self.dic objectForKey:@"opentime"]];
    self.ageELabel.text = [NSString stringWithFormat:@"开班时间结束：%@",[self.dic objectForKey:@"opentime_end"]];
    
}


/*
 tag；
 0：返回
 1：下一步
 2：返回Home页面
 */

-(IBAction)ApplyDetailsBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 2:
            [self next];
            break;
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
    
}


-(void)next
{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    if (app.Login) {
        [self performSegueWithIdentifier:@"applyDetails_applyCard" sender:[self.applyDetailsKey objectForKey:@"classid"]];
    }
    else
    {
        __unsafe_unretained ApplyClassDetailsViewController *safe_self = self;
        self.alertView = [[ApplyAlertView alloc]initWithView:self.view title:@"请登录后进行操作"];
        
        self.alertView.ApplyCardBlock = ^(int a)
        {
            [safe_self.alertView hide];
           [self performSelector:@selector(logout) withObject:self afterDelay:.5f];
        };
        
        [self.alertView show];
    }
    
}
//这个方法只弹出登录界面
- (void)logout
{
    [LoginViewController logOut];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"applyCardKey"];
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

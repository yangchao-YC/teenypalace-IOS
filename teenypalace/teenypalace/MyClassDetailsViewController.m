//
//  MyClassDetailsViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/1/7.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

//用户中心-班级信息详情

#import "MyClassDetailsViewController.h"

@interface MyClassDetailsViewController ()


@property (nonatomic,retain) NSDictionary *dic;
@end

@implementation MyClassDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"%@",self.MyClassDetailsKey);
    
    self.classNameLabel.text = [NSString stringWithFormat:@"班级名称：%@",[self.MyClassDetailsKey objectForKey:@"field_signup_class_name"]];
    [SVProgressHUD showInfoWithStatus:LOADING];
    
    
    NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_CLASS_DETAILS,
                      [self.MyClassDetailsKey objectForKey:@"field_signup_class_id"]];
    
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
    
    self.yearLabel.text = [NSString stringWithFormat:@"年份：%@",[self.dic objectForKey:@"year"]];
    self.quarterLabel.text = [NSString stringWithFormat:@"季度：%@",[self.dic objectForKey:@"jidu"]];
    self.timeBeginLabel.text = [NSString stringWithFormat:@"开班时间开始：%@",[self.dic objectForKey:@"opentime"]];
    self.timeEndLabel.text = [NSString stringWithFormat:@"开班时间结束：%@",[self.dic objectForKey:@"opentime_end"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"learnaddress"]];
    self.timeLabel.numberOfLines = 0;
    self.sumTimeLabel.text = [NSString stringWithFormat:@"总课时：%@",[self.dic objectForKey:@"zongkeshi"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"学费：%@",[self.dic objectForKey:@"tuition"]];
    
}
 

-(IBAction)MyClassDetailsBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            
            break;
    }
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

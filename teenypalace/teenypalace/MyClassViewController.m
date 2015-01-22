//
//  MyClassViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//用户中心-已报名课程

#import "MyClassViewController.h"
#import "CardClassTableViewCell.h"
@interface MyClassViewController ()

@property (nonatomic,retain) NSMutableArray *articles;

@end
@implementation MyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    AppDelegate *app = [[UIApplication sharedApplication]delegate ];
    
    
    NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_APPLY_CLASS,app.ParentId];
    
    [SVProgressHUD showInfoWithStatus:LOADING];
    
    [self dateUrl:date];
    
    
}



-(void)dateUrl:(NSString *)url
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = responseObject;
        [self dateHandle];
        
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
    if (self.articles.count !=0) {
        [self.tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"您还没有已报名课程" maskType:3];
    }
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *myCardClass_cell_id = @"myCardClass_cell_id";
    
    CardClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCardClass_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic =[self.articles objectAtIndexedSubscript:indexPath.row];
    cell.classNameLabel.text = [dic objectForKey:@"field_signup_class_name"];
    cell.nameLabel.text = [dic objectForKey:@"field_signup_student_name"];
    cell.cardLabel.text = [dic objectForKey:@"field_signup_student_card"];
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;//设置显示行数
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;//设置为只有一个模块
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic =[self.articles objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"myMoney_myClassDteails" sender:dic];}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"MyClassDetailsKey"];
}



-(IBAction)MyClassBtn:(UIButton *)sender
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

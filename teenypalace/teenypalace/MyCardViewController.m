//
//  MyCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.


//用户中心-学员卡管理

#import "MyCardViewController.h"


@interface MyCardViewController ()

@property (nonatomic,retain) NSMutableArray *articles;
@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_CARD,app.ParentId];
    
    NSLog(@"%@",date);
    
    
    [SVProgressHUD showInfoWithStatus:LOADING];
    
    [self dateUrl:date];
    
}

/*
 key:
 0.拉取学员卡列表
 1.是否报名成功
 */

-(void)dateUrl:(NSString *)url
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = responseObject;
        [self dateHandle:0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
    
}


/*
 数据处理
 */
-(void)dateHandle:(int)key
{
        if (self.articles.count>0) {
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"您还没有学员卡" maskType:3];
        }
        
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *myCard_cell_id = @"myCard_cell_id";
    
    CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCard_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"学院卡号：%@",[dic objectForKey:@"field_student_card"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",[dic objectForKey:@"field_student_name"]];
    if ([[dic objectForKey:@"field_student_sex"] intValue] == 1) {
        cell.sexLabel.text = @"性别：男";
    }
    else
    {
        cell.sexLabel.text = @"性别：女";
    }
    
    cell.birthdayLabel.text = [NSString stringWithFormat:@"出生年月：%@",[dic objectForKey:@"field_student_birthday"]];
    
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
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     UIViewController *push = segue.destinationViewController;
     [push setValue:sender forKey:@"MyNewKey"];
}



-(IBAction)MyCardBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"myCard_myNewCard" sender:@"0"];
            break;
        case 2:
            [self performSegueWithIdentifier:@"myCard_myNewCard" sender:@"1"];
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

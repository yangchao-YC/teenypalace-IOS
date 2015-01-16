//
//  ApplyCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//在线报名-学员卡列表页面

#import "ApplyCardViewController.h"

@interface ApplyCardViewController ()

@property (nonatomic,strong)ApplyAlertView *alertView ;

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSDictionary *dic;

@end



@implementation ApplyCardViewController

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
 报名
 card：学员卡号
 classID：班级ID
 */
-(void)datePost:(NSString *)card
{
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    /*
     field_signup_parents_phone 账号
     field_signup_parents_id    家长ID
     field_signup_student_card  学员卡号
     field_signup_class_id      班级ID
     lastlogintime              最后登陆时间
     */
    [requestManager POST:DATE_APPLY_CLASS parameters:
  @{@"field_signup_parents_phone":app.UserName,
    @"field_signup_parents_id":app.ParentId,
    @"field_signup_student_card":card,
    @"field_signup_class_id":self.applyCardKey,
    @"lastlogintime":app.LastloginTime}success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dic = responseObject;
        [self dateHandle:1];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:3];//异常提示
    }];
}

/*
 数据处理
 */
-(void)dateHandle:(int)key
{
    if (key == 0) {//刷新列表
        if (self.articles.count>0) {
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"您还没有学员卡" maskType:3];
        }
        
    }
    else
    {
        
        if ([[self.dic objectForKey:@"status"] intValue] == 0) {
            [SVProgressHUD dismiss];
            __unsafe_unretained ApplyCardViewController *safe_self = self;
            self.alertView = [[ApplyAlertView alloc]initWithView:self.view title:@"报名成功，是否跳转到结算中心"];
            
            self.alertView.ApplyCardBlock = ^(int a)
            {
                [safe_self.alertView hide];
                
                [safe_self push];
                
            };
            
            [self.alertView show];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:3];
        }
       
    }
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_class_cell_id = @"apply_card_cell_id";
    
    ApplyCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_class_cell_id];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    cell.cardLabel.text = [NSString stringWithFormat:@"学院卡号：%@",[dic objectForKey:@"field_student_card"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",[dic objectForKey:@"field_student_name"]];
    if ([[dic objectForKey:@"field_student_sex"] intValue] == 1) {
        cell.sexLabel.text = @"性别：男";
    }
    else
    {
        cell.sexLabel.text = @"性别：女";
    }
    
    cell.timeLabel.text = [NSString stringWithFormat:@"出生年月：%@",[dic objectForKey:@"field_student_birthday"]];
    
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
    
    return 89;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showWithStatus:@"正在报名..."];
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    [self datePost:[dic objectForKey:@"field_student_card"]];
}


-(void)ApplyCardBlock:(void (^)(void))blok
{
    NSLog(@"我收到了要跳转的消息");
   
}




-(IBAction)ApplyCardBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
    
}

-(void)push
{
    [self performSegueWithIdentifier:@"applyCard_myMoney" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   // UIViewController *push = segue.destinationViewController;
   // [push setValue:sender forKey:nil];
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

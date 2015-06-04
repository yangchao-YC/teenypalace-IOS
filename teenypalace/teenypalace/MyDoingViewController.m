//
//  MyDoingViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/4/29.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "MyDoingViewController.h"
#import "MyDoingTableViewCell.h"
@interface MyDoingViewController ()

@property (nonatomic,retain) NSMutableArray *articles;


@end

@implementation MyDoingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    AppDelegate *app = [[UIApplication sharedApplication]delegate ];
    
    if (app.Login) {
        NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_MY_DOING,app.ParentId];
        
        [SVProgressHUD showWithStatus:LOADING];
        
        [self dateUrl:date];
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请登陆后进行操作" maskType:3];
    }
    
}



-(void)dateUrl:(NSString *)url
{
    
    NSLog(@"活动页面:%@ ",url);
    
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
    
    if (self.articles.count !=0) {
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"您还没有已报名活动" maskType:3];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *myCardClass_cell_id = @"my_doing_cell";
    
    MyDoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCardClass_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic =[self.articles objectAtIndexedSubscript:indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.nameLabel.text = [NSString stringWithFormat:@"学生姓名：%@",[dic objectForKey:@"username"]];
    cell.phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",[dic objectForKey:@"contactinfo"]];
    cell.timeLabel.text = [NSString stringWithFormat:@"活动时间：%@",[dic objectForKey:@"createtime"]];
    cell.idLabel.text = [NSString stringWithFormat:@"报名编号：%@",[dic objectForKey:@"id"]];
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
    
    return 142;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"MyClassDetailsKey"];
}
*/
-(IBAction)MyDoingBtn:(UIButton *)sender
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

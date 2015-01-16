//
//  ApplyProfessionalViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/26.
//  Copyright (c) 2014年 杨超. All rights reserved.
//


//选择专业页面


#import "ApplyProfessionalViewController.h"

@interface ApplyProfessionalViewController ()


@property (nonatomic,retain) NSMutableArray *articles;


@end


@implementation ApplyProfessionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    NSString *date = [NSString stringWithFormat:@"%@%d",DATE_SEARCH_PROFESSIONAL,[self.applyProfessionaKey intValue]+1];
    
    [SVProgressHUD showInfoWithStatus:LOADING maskType:2];
    
    [self dateUrl:date];
  
}



-(void)dateUrl:(NSString *)url
{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = responseObject;
        dispatch_async(dispatch_get_main_queue(), ^{//脱离异步线程，在主线程中执行
            [self dateHandle];
        });
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}
/*
 数据处理
 */
-(void)dateHandle
{
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_cell_id = @"apply_cell_id";
    
    ApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉蓝色高亮
    
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dic objectForKey:@"title"];
    
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
    
    return 70;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"qc"] intValue] == 0) {
        [SVProgressHUD showInfoWithStatus:@"该专业目前没有相应班级可以报名" maskType:3];
    }
    else
    { 
        [self performSegueWithIdentifier:@"applyProfessional_applyLevel" sender:[dic objectForKey:@"id"]];
    }
}


-(IBAction)ApplyProfessionaBtn:(UIButton *)sender
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"applyLevelKey"];
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

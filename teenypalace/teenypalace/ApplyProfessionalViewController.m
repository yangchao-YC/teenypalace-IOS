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
    
    NSLog(@"我是专业面的key---%@",self.applyKey);
    //DATE_SEARCH_PROFESSIONAL;
    
    NSString *date = [NSString stringWithFormat:@"%@1",DATE_SEARCH_PROFESSIONAL];
    NSLog(@"            %@            ",date);
    
    [self dateUrl:date];
    
}



-(void)dateUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_cell_id = @"apply_cell_id";
    
    ApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = ART;
            break;
        case 1:
            cell.titleLabel.text = LITERARY;
            break;
        case 2:
            cell.titleLabel.text = GYM;
            break;
        case 3:
            cell.titleLabel.text = LANGUAGE;
            break;
        case 4:
            
            cell.titleLabel.text = CHILDREN;
            break;
            
        default:
            break;
    }

    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//设置显示行数
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

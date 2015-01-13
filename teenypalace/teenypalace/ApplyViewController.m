//
//  ApplyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/17.
//  Copyright (c) 2014年 杨超. All rights reserved.




//  在线报名



#import "ApplyViewController.h"

@interface ApplyViewController ()


@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    
    ApplyTableViewCell *cell = (ApplyTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
  //  cell.titleLabel.text = @" 张小朝";
    
    
    [self performSegueWithIdentifier:@"apply_applyProfessional" sender:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    
    
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"applyKey"];
}





-(IBAction)ApplyBtn:(UIButton *)sender
{
   [self.navigationController popViewControllerAnimated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

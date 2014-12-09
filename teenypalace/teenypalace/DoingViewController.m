//
//  DoingViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/4.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "DoingViewController.h"

@interface DoingViewController ()

@end

@implementation DoingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    // [self.tableView addHeaderWithTarget:self action:@selector(headerrereshing)];//绑定MJ刷新头部
    
    //  [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
    
    
    //[self.tableView headerBeginRefreshing];//自动执行下啦刷新
    //[self.tableView footerBeginRefreshing];
    
    
}

//下拉刷新执行
-(void)headerrereshing
{
    [self.tableView reloadData];//将数据放入数组后填入tableview
    [self.tableView headerEndRefreshing];
}

//加载更多执行
-(void)footerRereshing
{
    
    [self.tableView reloadData];//将数据放入数组后填入tableview
    [self.tableView footerEndRefreshing];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    
    static NSString *apply_cell_id = @"apply_cell_id";
    
   // ApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
*/
    
    return nil;
    
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




-(IBAction)DoingBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [self performSegueWithIdentifier:@"doing_doingDetails" sender:@"yy"];
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"doingKey"];
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

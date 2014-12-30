//
//  MyCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.


//用户中心-学员卡管理

#import "MyCardViewController.h"


@interface MyCardViewController ()

@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *myCard_cell_id = @"myCard_cell_id";
    
    CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCard_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;//设置显示行数
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
    // UIViewController *push = segue.destinationViewController;
    // [push setValue:sender forKey:@"MyKey"];
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

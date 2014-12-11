//
//  ApplyCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//在线报名-学员卡列表页面

#import "ApplyCardViewController.h"

@interface ApplyCardViewController ()

@end

@implementation ApplyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSLog(@"我是层次页面的key---%@",self.applyCardKey);
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_class_cell_id = @"apply_card_cell_id";
    
    ApplyCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_class_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.cardLabel.text = ART;
            break;
        case 1:
            cell.cardLabel.text = LITERARY;
            break;
        case 2:
            cell.cardLabel.text = GYM;
            break;
        case 3:
            cell.cardLabel.text = LANGUAGE;
            break;
        case 4:
            cell.cardLabel.text = CHILDREN;
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
    
    return 89;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

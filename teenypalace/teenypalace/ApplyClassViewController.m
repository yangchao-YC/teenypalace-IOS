//
//  ApplyClassViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/9.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "ApplyClassViewController.h"

@interface ApplyClassViewController ()

@end

@implementation ApplyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSLog(@"我是层次页面的key---%@",self.applyClassKey);
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_class_cell_id = @"apply_class_cell_id";
    
    ApplyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_class_cell_id];
    
    
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
    
    return 130;
}//设置模块内cell的高度

//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(IBAction)ApplyClassBtn:(UIButton *)sender
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
    //[push setValue:sender forKey:@"applyLevelKey"];
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
//
//  ApplyClassViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/9.
//  Copyright (c) 2014年 杨超. All rights reserved.
//在线报名-班级列表页面


#import "ApplyClassViewController.h"

@interface ApplyClassViewController ()

@property (nonatomic,retain) NSMutableArray *articles;
@end

@implementation ApplyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    NSString *level1 =[self.applyClassKey objectForKey:@"level1"] == NULL?@"0":[self.applyClassKey objectForKey:@"level1"];
    NSString *level2 =[self.applyClassKey objectForKey:@"level2"] == NULL?@"0":[self.applyClassKey objectForKey:@"level2"];

    NSString *level3 =[self.applyClassKey objectForKey:@"level3"] == NULL?@"0":[self.applyClassKey objectForKey:@"level3"];

    
    NSString *date = [NSString stringWithFormat:@"%@%@/%@/%@/%@",DATE_SEARCH_CLASS,
                      [self.applyClassKey objectForKey:@"zhuanyid"],level1,level2,level3];
    
    [SVProgressHUD showInfoWithStatus:LOADING];

    [self dateUrl:date];
    
}



-(void)dateUrl:(NSString *)url
{
    NSLog(@"班级列表：  %@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = responseObject;
        dispatch_async(dispatch_get_main_queue(), ^{//脱离异步线程，在主线程中执行
            [self dateHandle];
        });
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
    [SVProgressHUD dismiss];
    [self.tableView reloadData];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_class_cell_id = @"apply_class_cell_id";
    
    ApplyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_class_cell_id];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dic objectForKey:@"classname"];
    cell.objectLabel.text = [NSString stringWithFormat:@"招生对象：%@-%@岁",[dic objectForKey:@"age_s"],[dic objectForKey:@"age_e"]];
    
    cell.timeLabel.text = [dic objectForKey:@"learnaddress"];

    cell.moneyLabel.text = [NSString stringWithFormat:@"学费：%@",[dic objectForKey:@"yuanjia"]];
    if ([[dic objectForKey:@"yuanjia"] isEqual:[dic objectForKey:@"tuition"]]) {
        cell.discountLabel.text = @"优惠价格：暂无优惠";
    }
    else
    {
         cell.discountLabel.text = [NSString stringWithFormat:@"优惠价格：%@",[dic objectForKey:@"tuition"]];
    }
   
    cell.beleftLabel.text = [NSString stringWithFormat:@"剩余名额：%@",[dic objectForKey:@"lave"]];
    
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

//预判高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}


#pragma mark 计算cell高度
//神坑啊
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IOS8_OR_LATER)
    {
        return UITableViewAutomaticDimension;
    }
    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [cell layoutIfNeeded];
    [cell.contentView layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1.0f; // Add 1.0f for the cell separator height
    
}


/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    NSString *learnaddress = [dic objectForKey:@"learnaddress"];
    
    int line = learnaddress.length/21;
    int lea = learnaddress.length;

    if (lea / 21 != 0) {
        if (lea/line == 21) {
            return 130 + (21*(line-1));
        }
        else
        {
            return 130;
        }
    }
    else
    {
        return 130;
    }
    
    
    
}//设置模块内cell的高度
*/
//下面为点击事件方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"applyClass_applyDetails" sender:dic];

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
    [push setValue:sender forKey:@"applyDetailsKey"];
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

//
//  MyMoneyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//用户中心-结算中心

#import "MyMoneyViewController.h"

@interface MyMoneyViewController ()
{
    BOOL countMoney ;//是否全选
    NSMutableArray *State;//状态
}
@end

@implementation MyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    countMoney = NO;
    self.sumMoneyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_no"]];
    
    State = [[NSMutableArray alloc]init];
    for (int i=9; i<20; i++) {
        [State addObject:@"0"];
    }

    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *myMoney_cell_id = @"myMoney_cell_id";
    
    MyMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myMoney_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.checkBtn.tag = indexPath.row;
    [cell.checkBtn addTarget:self action:@selector(tableViewBtn:IndexPath:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *state = [State objectAtIndex:indexPath.row];
    if ([state isEqualToString:@"0"]) {
        cell.checkBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_no"]];
    }
    
    
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;//设置显示行数
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;//设置为只有一个模块
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 110;
}//设置模块内cell的高度


-(void)tableViewBtn:(UIButton *)sender IndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%long",sender.tag);
   // NSIndexPath *inte = sender.tag;
   // [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];

   // [State replaceObjectAtIndex:indexPath.row withObject:@"1"];
    NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    MyMoneyTableViewCell *cell = (MyMoneyTableViewCell *)[self.tableView cellForRowAtIndexPath:index];
    
    cell.classNameLabel.text = @"222";
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
    
   
    
}

-(IBAction)tableBtnClick:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];//把触摸的事件放到集合里
    UITouch *touch = [touches anyObject];//把事件放到触摸的对象里
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];//把触发的这个点转成二位坐标
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];//匹配坐标点
    if (indexPath != nil) {
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

//按钮的触发方法
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"图片    %d",indexPath.row);
    
    MyMoneyTableViewCell *cell = (MyMoneyTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.classNameLabel.text = @"图片选择";
}


//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"行     %d",indexPath.row);
    
    
   
}


/*tag
 0:返回
 1:全选
 2:结算
 3:删除
 */
-(IBAction)MyMoneyBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            if (countMoney) {
                self.sumMoneyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_no"]];
                countMoney = NO;
            }
            else
            {
                self.sumMoneyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_yes"]];
                countMoney = YES;
            }
            break;
        case 2:
            break;
        case 3:
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

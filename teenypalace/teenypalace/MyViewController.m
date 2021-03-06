//
//  MyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/17.
//  Copyright (c) 2014年 杨超. All rights reserved.




//用户中心



#import "MyViewController.h"
#import "LoginViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.tableView.bounces = NO;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSLog(@"我是层次页面的key---%@",self.MyKey);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"notifiction_my" object:nil];
    
}

-(void)notification:(NSNotification *)not
{
    [self.tableView reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *apply_cell_id = @"apply_cell_id";
    
    ApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"学员卡管理";
            break;
        case 1:
            cell.titleLabel.text = @"已报名课程";
            break;
        case 2:
            cell.titleLabel.text = @"已报名活动";
            break;
        case 3:
            cell.titleLabel.text = @"结算中心";
            break;
        case 4:
            cell.titleLabel.text = @"关于";
            break;
        case 5:
            cell.titleLabel.text = @"消息中心";
            break;
        case 6:
            if ([YLLAccountManager sharedAccountManager].f_isLogined) {
                cell.titleLabel.text = @"退出当前账号";
                
            }
            else
            {
                cell.titleLabel.text = @"登  录";
            }
            break;
        default:
            break;
    }
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;//设置显示行数
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
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"my_myCard" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"my_myClass" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"my_myDoing" sender:nil];
            break;
        case 3:
            [self performSegueWithIdentifier:@"my_myMoney" sender:nil];
            break;
        case 4:
            [self performSegueWithIdentifier:@"my_mySite" sender:nil];
            break;
        case 5:
            [self performSegueWithIdentifier:@"my_myNotifiaction" sender:nil];
            break;
        case 6:
            
            [self logout];
            break;
        default:
            break;
    }
    
    
}



- (void)logout
{
    [self performSelector:@selector(dialoLogin) withObject:self afterDelay:.2f];
    
    YLLAccountManager *accountManager = [YLLAccountManager sharedAccountManager];
    accountManager.f_isLogined = NO;//登陆成功
    accountManager.f_userID = nil;//存储家长ID
    accountManager.f_time = nil;///存储最后登陆时间
    
    
    
    
    [self.tableView reloadData];
    
}
-(void)dialoLogin
{
    [LoginViewController logOut];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   // UIViewController *push = segue.destinationViewController;
   // [push setValue:sender forKey:@"MyKey"];
}



-(IBAction)MyBtn:(UIButton *)sender
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

//
//  MyMoneyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//用户中心-结算中心

#import "MyMoneyViewController.h"
#import "ApplyAlertView.h"
#import "UPOMPStage.h"
#import "LoginViewController.h"
@interface MyMoneyViewController ()
{
    BOOL countMoney ;//是否全选
    NSMutableArray *contacts;//状态
    int sumMoney;//总价
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,strong)ApplyAlertView *alertView ;
@property (nonatomic,retain) NSDictionary *dic;
@property (nonatomic,retain) AppDelegate *app;
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
    
    contacts = [NSMutableArray array];
    sumMoney = 0;
    self.app = [[UIApplication sharedApplication]delegate];
    if (self.app.Login) {
        [SVProgressHUD showInfoWithStatus:LOADING];
        [self selectMoney];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请先登陆在进行操作" maskType:3];
    }
 
}



/*
 查询订单
 */

-(void)selectMoney
{
    countMoney = NO;
    sumMoney = 0;
    
    for (NSDictionary *dic in contacts) {
        [dic setValue:@"NO" forKey:@"checked"];
    }
    
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    NSString *date = [NSString stringWithFormat:@"%@%@/1",DATE_SEARCH_MONEY,app.ParentId];
    
    [self dateUrl:date Key:0];
    

}

- (void)logout
{
    [LoginViewController logOut];
}

//key:0查询订单 1删除订单
-(void)dateUrl:(NSString *)url Key:(int)key
{
    NSLog(@"%@",url);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (key == 0) {
            self.articles = responseObject;
        }
        else
        {
            self.dic = responseObject;
        }
        
        [self dateHandle:key];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
    
}
/*
 数据处理
 key
 0:查询订单
 1：删除订单
 2：支付订单生成
 */
-(void)dateHandle:(int)key
{
    
    if (key == 0) {
        if (self.articles.count != 0) {
            for (int i = 0; i <self.articles.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:@"NO" forKey:@"checked"];
                [contacts addObject:dic];
            }
            
            [self.tableView reloadData];
        }
        else {
            [SVProgressHUD showInfoWithStatus:@"没有订单" maskType:3];
        }
        
    }
    else if (key == 1)
    {
        if ([[self.dic objectForKey:@"status"]intValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功,正在刷新订单" maskType:3];
            [self selectMoney];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:3];
        }
    }
    else
    {
        if ([[self.dic objectForKey:@"status"]intValue] == 0) {
            [SVProgressHUD dismiss];
            [self goUPOMPView:[self.dic objectForKey:@"msg"]];
            
        }
        else{
            [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:3];
        }
    }
    //NSLog(@"key:%@.   数据数目：%d    contacts:%d",key,self.articles.count,contacts);
    
}


-(void)goUPOMPView:(NSString *)infoXML
{
   // NSString *retrunText = [[NSString alloc] initWithData:infoXML encoding:NSUTF8StringEncoding];
    UPOMPStage *upomp = [[UPOMPStage alloc] initUPOMPPayWithXML:infoXML PaymentMode:DefaultPayment ServerType:ServerProduct delegate:self];
    [self presentModalViewController:upomp animated:YES];
    
}

-(void)closeUPOMPWithXMLString:(NSString *)xmlString
{
    UPOMPXMLParser *xmlParser = [[UPOMPXMLParser alloc] init];
    NSDictionary *xmlDic = [[NSDictionary alloc]initWithDictionary:[xmlParser parserXML:xmlString]];
    
    NSString *respCode = [xmlDic objectForKey:@"respCode"];
    
    if ([respCode isEqualToString:@"0000"]) {
        [SVProgressHUD showSuccessWithStatus:@"支付成功" maskType:3];
        
        [SVProgressHUD showInfoWithStatus:@"正在刷新列表"];
        [self selectMoney];
        
    }
    else if ([respCode isEqualToString:@"9000"]) {
        [SVProgressHUD showInfoWithStatus:@"用户取消支付" maskType:3];
    }
    else if ([respCode isEqualToString:@"9001"]) {
       [SVProgressHUD showInfoWithStatus:@"用户退出插件" maskType:3];
    }
    else if ([respCode isEqualToString:@"9002"]) {
        [SVProgressHUD showInfoWithStatus:@"插件初始化失败" maskType:3];
    }
    else if ([respCode isEqualToString:@"9003"]) {
       [SVProgressHUD showInfoWithStatus:@"商户无预授权权限" maskType:3];
    }
    else if ([respCode isEqualToString:@"9004"]) {
       [SVProgressHUD showInfoWithStatus:@"单点登录成功" maskType:3];
    }
    else if ([respCode isEqualToString:@"9005"]) {
       [SVProgressHUD showInfoWithStatus:@"单点登录失败" maskType:3];
    }
    else if ([respCode isEqualToString:@"9008"]) {
        [SVProgressHUD showInfoWithStatus:@"共享卡列表成功" maskType:3];
    }
    else if ([respCode isEqualToString:@"9009"]) {
       [SVProgressHUD showInfoWithStatus:@"共享卡列表失败" maskType:3];
    }
    else{
        [SVProgressHUD showInfoWithStatus:@"支付失败" maskType:3];
    }
    
}

/*
 是否全选
 */
- (void)allSelect
{
    sumMoney = 0;
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        MyMoneyTableViewCell *cell = (MyMoneyTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if (!countMoney) {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    if (!countMoney){
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"YES" forKey:@"checked"];
        }
        
        [self sumMoney:2 money:0];
        countMoney = YES;
    }else{
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        countMoney = NO;
        self.sumMoneyLabel.text = @"全选：合计0.00元";
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * identifier = @"myMoney_cell_id";
    MyMoneyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyMoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    NSDictionary *dicDate = [self.articles objectAtIndex:indexPath.row];
    
    cell.classNameLabel.text = [dicDate objectForKey:@"field_signup_class_name"];
    cell.nameLabel.text = [NSString stringWithFormat:@"学员姓名：%@",[dicDate objectForKey:@"field_signup_student_name"]];
    cell.numbelLabel.text = [NSString stringWithFormat:@"学员卡编号：%@",[dicDate objectForKey:@"field_signup_student_card"]];
    cell.moneyLabel.text = [NSString stringWithFormat:@"学费：%@",[dicDate objectForKey:@"field_signup_payamount"]];
    
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
    
    return 110;
}//设置模块内cell的高度



/*
 点击更换状态
 */
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyMoneyTableViewCell *cell = (MyMoneyTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        NSLog(@"选择1");
        [self sumMoney:0 money:(int)indexPath.row];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        NSLog(@"选择2");
        [self sumMoney:1 money:(int)indexPath.row];
        [cell setChecked:NO];
    }
    
}


/*
 计算价格：
 action：
 0加
 1减
 2总价
 money：价格
 */
-(void)sumMoney:(int)action money:(int)money
{
    
    switch (action) {
        case 0:
            sumMoney = sumMoney + [[[self.articles objectAtIndex:money] objectForKey:@"field_signup_payamount"] intValue];
            break;
        case 1:
            sumMoney = sumMoney - [[[self.articles objectAtIndex:money] objectForKey:@"field_signup_payamount"] intValue];
            
            break;
        case 2:
            for (int i = 0; i<self.articles.count; i++) {
                sumMoney = sumMoney + [[[self.articles objectAtIndex:i] objectForKey:@"field_signup_payamount"] intValue];
            }
            break;
        default:
            break;
    }
    
    self.sumMoneyLabel.text = [NSString stringWithFormat:@"全选：合计%d.00元",sumMoney];
    
    
}
//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic =[self.articles objectAtIndex:indexPath.row];
   [self performSegueWithIdentifier:@"myMoney_myClassDetails" sender:dic];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     UIViewController *push = segue.destinationViewController;
     [push setValue:sender forKey:@"MyClassDetailsKey"];
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
            }
            else
            {
                self.sumMoneyBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_yes"]];
            }
            [self allSelect];
            break;
        case 2:
            [self check];
            break;
        case 3:
            
            [self delete];
            
            break;
            
        default:
            
            break;
    }
}
/*删除订单*/
-(void)delete
{
    NSMutableArray *payArray = [NSMutableArray array];
    
    for (int i = 0; i<contacts.count; i++) {
        if ([[[contacts objectAtIndex:i] objectForKey:@"checked"] isEqualToString:@"YES"]) {
            NSLog(@"%d",i);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSLog(@"打印删除ID  %@",[[self.articles objectAtIndex:i] objectForKey:@"orderid"]);
            [dic setValue:[[self.articles objectAtIndex:i] objectForKey:@"orderid"] forKey:@"number"];
            [payArray addObject:dic];
        }
    }
    if (payArray.count>0) {
        __unsafe_unretained MyMoneyViewController *safe_self = self;
        self.alertView = [[ApplyAlertView alloc]initWithView:self.view title:@"是否删除已勾选项目？"];
        
        self.alertView.ApplyCardBlock = ^(int a)
        {
            [safe_self.alertView hide];
            
            NSString *orderids = @"";
            
            if (payArray.count == 1) {
                orderids = [NSString stringWithFormat:@"%@",[[payArray objectAtIndex:0] objectForKey:@"number"]];
            }
            else
            {
                for (int i = 0; i<payArray.count; i++) {
                    NSString *number =[NSString stringWithFormat:@"%@",[[payArray objectAtIndex:i] objectForKey:@"number"]];
                    NSString *b;
                    if (i == (payArray.count -1)) {
                        b = @"";
                    }
                    else
                    {
                        b=@",";
                    }
                    orderids = [NSString stringWithFormat:@"%@%@%@",orderids,number,b];
                }
            }
            
            [SVProgressHUD showInfoWithStatus:@"正在删除订单..."];
            
             NSString *date = [NSString stringWithFormat:@"%@%@",DATE_SEARCH_MONEY_DELETE,orderids];
            
            NSLog(@"我打印删除订单   %@",date);
            
            [self dateUrl:date Key:1];
   
        };
        
        [self.alertView show];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请选择要删除的订单" maskType:3];
    }
}




/*
 结算
 */
-(void)check
{
    NSMutableArray *payArray = [NSMutableArray array];
    
    for (int i = 0; i<contacts.count; i++) {
        if ([[[contacts objectAtIndex:i] objectForKey:@"checked"] isEqualToString:@"YES"]) {
            NSLog(@"%d",i);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[[self.articles objectAtIndex:i] objectForKey:@"oa_orderid"] forKey:@"number"];
            [dic setValue:[[self.articles objectAtIndex:i] objectForKey:@"field_signup_payamount"] forKey:@"money"];
            [payArray addObject:dic];
        }
    }
    if (payArray.count>0) {
        NSString *money = [NSString stringWithFormat:@"您选择的项目总金额为人民币%d.00元是否现在进行支付？",sumMoney];
        
        __unsafe_unretained MyMoneyViewController *safe_self = self;
        self.alertView = [[ApplyAlertView alloc]initWithView:self.view title:money];
        
        self.alertView.ApplyCardBlock = ^(int a)
        {
            [safe_self.alertView hide];
            
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSString *time=[NSString stringWithFormat:@"%f",[dat timeIntervalSince1970]*1000];
            
            time = [time substringToIndex:13];
            
            NSLog(@"timeSp:%@",time); //时间戳的值

            NSString *times = [NSString stringWithFormat:@"%@%@%@", time,app.ParentId,[[payArray objectAtIndex:0] objectForKey:@"number"]];//获取时间戳
            NSString *orderids = @"";
            if (payArray.count == 1) {
                orderids = [NSString stringWithFormat:@"%@-%@",[[payArray objectAtIndex:0] objectForKey:@"number"],[[payArray objectAtIndex:0] objectForKey:@"money"]];
            }
            else
            {
                for (int i = 0; i<payArray.count; i++) {
                    NSString *number =[NSString stringWithFormat:@"%@-%@",[[payArray objectAtIndex:i] objectForKey:@"number"],[[payArray objectAtIndex:i] objectForKey:@"money"]];
                    NSString *b;
                    if (i == (payArray.count -1)) {
                        b = @"";
                    }
                    else
                    {
                        b=@",";
                    }
                    orderids = [NSString stringWithFormat:@"%@%@%@",orderids,number,b];
                }
            }
            
            [SVProgressHUD showInfoWithStatus:@"正在生成支付订单..."];
            
            [self datePost:times Orderids:orderids];
            
            
            
        };
        
        [self.alertView show];
        
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请选择要支付的订单" maskType:3];
    }
}

/*
 提交订单
 merchantorderid：订单号
 orderids：订单编号
 */
-(void)datePost:(NSString *)merchantorderid Orderids:(NSString *)orderids
{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    /*
     field_unionpay_merchantorderid 支付订单号
     field_unionpay_orderids    订单编号
     field_unionpay_parentid  家长ID
     field_unionpay_parent_phone      家长电话
     */
    [requestManager POST:DATE_SEARCH_MONEY_PAY parameters:
     @{@"field_unionpay_merchantorderid":merchantorderid,
       @"field_unionpay_orderids":orderids,
       @"field_unionpay_parentid":app.ParentId,
       @"field_unionpay_parent_phone":app.UserName
       }success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"JSON: %@", responseObject);
           self.dic = responseObject;
           [self dateHandle:2];
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
           NSString *errorString = [NSString stringWithFormat:@"%@",error];
           [SVProgressHUD showInfoWithStatus:errorString maskType:3];//异常提示
       }];
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

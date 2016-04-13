//
//  MyNotifiactionViewController.m
//  teenypalace
//
//  Created by 杨超 on 16/3/2.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import "MyNotifiactionViewController.h"
#import "NotifiactionTableViewCell.h"
@interface MyNotifiactionViewController ()
{
    NSMutableArray *heightArray;
    NSString *url;
}

@property (nonatomic,retain) NSMutableArray *articles;


@end

@implementation MyNotifiactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.articles = [[NSMutableArray alloc]init];
    
    self.tableView.bounces = NO;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
   // AppDelegate *app = [[UIApplication sharedApplication]delegate];

    url = NOTIFIACTION;
    
    if ([YLLAccountManager sharedAccountManager].f_isLogined) {
        url = [NSString stringWithFormat:@"%@%@",url,[YLLAccountManager sharedAccountManager].f_userID,nil];
    }
    
    [SVProgressHUD showInfoWithStatus:@"正在查询"];
    [self dateUrl];
    
}

-(IBAction)Btn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            
            break;
    }
}


-(void)dateUrl
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"JSON: %@", responseObject);
        [SVProgressHUD dismiss];
        self.articles = [NSMutableArray arrayWithArray:responseObject];
        [self dateHandle];
        
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
    if (self.articles.count >0) {
        // if (start) {//如果是第一次刷新
         heightArray =[[NSMutableArray alloc]init];
        for (int i=0; i<self.articles.count; i++) {
            [heightArray addObject:@"75"];
        }
        
        [ self.tableView reloadData];//将数据放入数组后填入tableview
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *message_professiona_cell_id = @"notifiaction_cell_id";
    
    NotifiactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:message_professiona_cell_id];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NotifiactionTableViewCell" owner:self options:nil]lastObject];
    }
    
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [self.articles objectAtIndex:indexPath.row];
    
    cell.Label_Title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"field_charity_title"]];
    cell.Label_Time.text = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"field_charity_msg_sendtime"]]substringToIndex:10];
    cell.Label_Content.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"field_pushmsg"]];
//   if(indexPath.row == 0)
//   {
//       cell.Label_Content.text =@"我是第一行，一一一一一一一一一一一一一第一，";
//   }
//   else if(indexPath.row == 1)
//    {
//        cell.Label_Content.text =@"我是第二行，二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二二";
//    }
//   else if(indexPath.row == 2)
//   {
//       cell.Label_Content.text =@"我是第三行，三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三";
//   }
//   else
//   {
//       cell.Label_Content.text =@"我是其他，其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他其他三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三三";
//   }
    
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
    if (heightArray == nil) {
        return 75;
    }
    return [[heightArray objectAtIndex:indexPath.row] intValue];
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifiactionTableViewCell *cell = (NotifiactionTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    //float wigth = cell.Label_Content.frame.size.width;
    int height = 75;
    
    CGRect Screensize = [UIScreen mainScreen].bounds;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    CGRect rect_content = [cell.Label_Content.text boundingRectWithSize:CGSizeMake(Screensize.size.width - 13.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];

    if (cell.Label_Content.frame.size.height == 38) { //25为xib设计contentLabel的原始高度
        if (rect_content.size.height > 38) {
            
            height = rect_content.size.height + 40;
            [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",height]];//更改指定索引的值
            [self.tableView reloadData];
        }
    }
    else
    {
        [heightArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",75]];//更改指定索引的值
        [self.tableView reloadData];
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

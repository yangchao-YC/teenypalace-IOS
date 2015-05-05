//
//  Doing.m
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "DoingFive.h"
#import "MJRefresh.h"
#import "DoingTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DoingFive()<UITableViewDelegate,UITableViewDataSource>
{
    int mark;
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSMutableArray *date;

@end




@implementation DoingFive


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect Screensize = [UIScreen mainScreen].bounds;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screensize.size.width, Screensize.size.height - 99) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [ self.tableView addHeaderWithTarget:self action:@selector(headerrereshing)];//绑定MJ刷新头部
        
        [ self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
        
        [self addSubview: self.tableView];
        
    }
    return self;
}


-(void)start
{
    [self.tableView headerBeginRefreshing];
}

/*
 mark:页数
 key:YES为下啦刷新   NO为加载更多
 */
-(void)dateUrl:(int)marks Key:(BOOL)key
{
    
    NSString *date = [NSString stringWithFormat:@"%@%d/pager/10",DATE_SEARCH_DOING_CRTRMONY,marks];
    
    NSLog(@"%@",date);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:date parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"JSON: %@", responseObject);
        self.articles = [NSMutableArray arrayWithArray:responseObject];
        [self dateHandle:key];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
       // NSLog(@"Error: %@", error);
    }];
}


/*
 数据处理
 */
-(void)dateHandle:(BOOL)key
{
    if (key) {//下拉刷新
        if (self.articles.count >0) {
                self.date = self.articles;
                [ self.tableView reloadData];//将数据放入数组后填入tableview
                [ self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView headerEndRefreshing];
            [SVProgressHUD showInfoWithStatus:@"没有数据" maskType:3];
        }
        
    }
    else{//加载更多
        if (self.articles.count >0) {
            for (int i =0; i < self.articles.count; i++) {
                id dic = [self.articles objectAtIndex:i];
                [self.date addObject:dic];//[self.articles objectAtIndex:i]];
            }
            

            [ self.tableView reloadData];//将数据放入数组后填入tableview
        }

      //  NSLog(@"%@",self.date);
        [ self.tableView footerEndRefreshing];
    }
    
}


//下拉刷新执行
-(void)headerrereshing
{
    mark = 1;
    [self dateUrl:mark Key:YES];
    
}

//加载更多执行
-(void)footerRereshing
{
    if (self.date.count/mark == 10) {
        mark +=1;
        [self dateUrl:mark Key:NO];
    }
    else
    {
        [ self.tableView footerEndRefreshing];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *doing_cell_id = @"doing_cell_id";
    
    DoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_id];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dic objectForKey:@"title"];
    
    cell.countLabel.hidden = YES;
    
    
    NSString *time = [dic objectForKey:@"created"];
    time = [time substringToIndex:10];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"更新时间：%@",time];
    [cell.images setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumb"]]
                   placeholderImage:[UIImage imageNamed:@"defaults"]];
     return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.date.count;//设置显示行数
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;//设置为只有一个模块
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    self.DoingBlock(dic);
}




@end

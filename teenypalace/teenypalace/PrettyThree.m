//
//  Doing.m
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "PrettyThree.h"
#import "MJRefresh.h"
#import "PrettyBumenTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface PrettyThree()<UITableViewDelegate,UITableViewDataSource>
{
    int mark;
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSMutableArray *date;

@end




@implementation PrettyThree


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
-(void)dateUrl:(int)marks
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:DATE_PRETTY_DEPARTMENTS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
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


//下拉刷新执行
-(void)headerrereshing
{
    mark = 0;
    [self dateUrl:0];
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *pretty_bumen_cell_id = @"pretty_bumen_cell_id";
    
    PrettyBumenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pretty_bumen_cell_id];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PrettyBumenTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [dic objectForKey:@"title"];
    
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
    
    return 120;
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    self.PrettyBlock(dic);
}




@end

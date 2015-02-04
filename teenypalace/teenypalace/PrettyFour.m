//
//  Doing.m
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "MJRefresh.h"
#import "MessageTeachreTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrettyFour.h"
@interface PrettyFour()<UITableViewDelegate,UITableViewDataSource>
{
    int mark;
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSMutableArray *date;

@end




@implementation PrettyFour


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
      //  self.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
        
        CGRect Screensize = [UIScreen mainScreen].bounds;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 5, Screensize.size.width -10, Screensize.size.height - 114) style:UITableViewStylePlain];
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
    
    NSString *date = [NSString stringWithFormat:@"%@%d",DATE_PRETTY_PLAN,marks];
    
    NSLog(@"%@",date);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:date parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.articles = [NSMutableArray arrayWithArray:responseObject];
        [self dateHandle:key];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        NSLog(@"Error: %@", error);
    }];
    
}


/*
 数据处理
 */
-(void)dateHandle:(BOOL)key
{
    if (key) {//下拉刷新
        //[self.tableView reloadData];
        if (self.articles.count >0) {
            // if (start) {//如果是第一次刷新
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
        
        NSLog(@"%@",self.date);
        [ self.tableView footerEndRefreshing];
    }
    
}


//下拉刷新执行
-(void)headerrereshing
{
    mark = 0;
    [self dateUrl:0 Key:YES];
    
}

//加载更多执行
-(void)footerRereshing
{
    if (self.date.count/(mark +1) == 5) {
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
    
    MessageTeachreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_id];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageTeachreTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    
    cell.imagesHeight.constant = 130;
    cell.imageTop.constant  = 10;
    cell.buttomImage.hidden = YES;
    
    [cell.images setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"field_youth_palace_plan_image"]]
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
    
    return 140;
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}




@end

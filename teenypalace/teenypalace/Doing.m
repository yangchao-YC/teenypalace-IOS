//
//  Doing.m
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "Doing.h"
#import "MJRefresh.h"
#import "DoingTableViewCell.h"


@interface Doing()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@end


@implementation Doing


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect Screensize = [UIScreen mainScreen].bounds;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screensize.size.width, Screensize.size.height - 99) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        [ self.tableView addHeaderWithTarget:self action:@selector(headerrereshing)];//绑定MJ刷新头部
        
        [ self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
        
        [self addSubview: self.tableView];
        
    }
    return self;
}



//下拉刷新执行
-(void)headerrereshing
{
    [ self.tableView reloadData];//将数据放入数组后填入tableview
    [ self.tableView headerEndRefreshing];
}

//加载更多执行
-(void)footerRereshing
{
    
    [ self.tableView reloadData];//将数据放入数组后填入tableview
    [ self.tableView footerEndRefreshing];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *doing_cell_id = @"doing_cell_id";
    
    DoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_id];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = @"呖咕呖咕的";
    
    return nil;
    
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
    
    return 70;
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end

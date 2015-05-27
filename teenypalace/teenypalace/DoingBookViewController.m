//
//  DoingBookViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/3/24.
//  Copyright (c) 2015年 杨超. All rights reserved.


//活动-图书介绍

#import "DoingBookViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "DoingBookHeaderView.h"
#import "DoingCommentTableViewCell.h"

@interface DoingBookViewController ()
{
    int mark ;
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSMutableArray *date;

@end

@implementation DoingBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [ self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
    [self.tableView setHeaderHidden:NO];//隐藏头部刷新控件
    self.tableView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1];
    mark = 1;
    self.date = [NSMutableArray array];
    
    [self dateUrl:mark];
   // NSLog(@"%@",self.doingKey);
    [self initHeader];
    
}


-(void)initHeader
{
    CGSize screenSize =[UIScreen mainScreen].bounds.size ;
    UIView *headerView =  [[UIView alloc]init];
    
    UIImageView *imageView = [UIImageView new];
    [headerView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenSize.width, screenSize.width));
        make.centerX.equalTo(imageView.superview);
        make.top.equalTo(imageView.superview);
    }];
    
    
    [imageView setImageWithURL:[NSURL URLWithString:[self.doingKey objectForKey:@"bookthumb"]] placeholderImage:[UIImage imageNamed:@"defaults"]];
    
    DoingBookHeaderView *mainView = [[[NSBundle mainBundle]loadNibNamed:@"DoingBookHeaderView" owner:self options:nil]lastObject];
    
    [headerView addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);
        make.left.right.equalTo(mainView.superview);
    }];
    
    mainView.titleLabel.text = [self.doingKey objectForKey:@"booktitle"];
    mainView.nameLabel.text = [self.doingKey objectForKey:@"bookauthor"];
    mainView.contentLabel.text = [self.doingKey objectForKey:@"bookintro"];
    mainView.commentLabel.text = [NSString stringWithFormat:@"评论%@条",[self.doingKey objectForKey:@"count"]];
    
    [mainView layoutIfNeeded];
    [headerView layoutIfNeeded];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    
    CGRect rect = [mainView.contentLabel.text boundingRectWithSize:CGSizeMake(screenSize.width - 8.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    CGFloat height = imageView.layer.bounds.size.height + 175 + rect.size.height;
    
    headerView.frame = CGRectMake(0, 0, screenSize.width, height);
    self.tableView.tableHeaderView = headerView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *doing_cell_comment = @"doing_cell_comment";
    
    DoingCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_comment];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCommentTableViewCell" owner:self options:nil]lastObject];
    }
    
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    
    
    
    NSString *phone = [dic objectForKey:@"phone"];
    phone = [phone substringToIndex:7];
    
    cell.phoneLabel.text = [NSString stringWithFormat:@"%@****",phone];
    
    cell.timeLabel.text = [dic objectForKey:@"created"];
    cell.contentLabel.text = [dic objectForKey:@"message"];
    
    return cell;
}



//加载更多执行
-(void)footerRereshing
{
    if (self.date.count/mark == 5) {
        mark +=1;
        [self dateUrl:mark];
    }
    else
    {
        [ self.tableView footerEndRefreshing];
    }
}

/*
 mark:页数
 */
-(void)dateUrl:(int)marks
{
    
    NSString *date = [NSString stringWithFormat:@"%@%@/page/%d",DATE_SEARCH_COMMENT,[self.doingKey objectForKey:@"id"],marks];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:date parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"JSON: %@", responseObject);
        self.articles = [NSMutableArray arrayWithArray:responseObject];
        [self dateHandle];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        // NSLog(@"Error: %@", error);
    }];
}


-(void)dateHandle
{
    if (self.articles.count >0) {
        for (int i =0; i < self.articles.count; i++) {
            id dic = [self.articles objectAtIndex:i];
            [self.date addObject:dic];//[self.articles objectAtIndex:i]];
        }
        
        [ self.tableView reloadData];
    }
    [ self.tableView footerEndRefreshing];
}


-(IBAction)DoingBookBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 2:
            [self performSegueWithIdentifier:@"doingBook_DoingComment" sender:self.doingKey];//进入评论
            break;
        default:
            break;
    }
}





//设置单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.date.count;
}

//点击触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


//预判高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *destinationController = segue.destinationViewController;
    [destinationController setValue:sender forKey:@"commentKey"];
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"doingCommentKey"];
}
 */

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

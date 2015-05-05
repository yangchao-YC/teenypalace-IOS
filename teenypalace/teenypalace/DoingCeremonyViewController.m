//
//  DoingCeremonyViewController.m
//  teenypalace
//
//  Created by 杨超 on 15/3/24.
//  Copyright (c) 2015年 杨超. All rights reserved.


//活动-祭奠活动

#import "DoingCeremonyViewController.h"

#import "DoingCeremonyTopTableViewCell.h"
#import "DoingCeremonyContentTableViewCell.h"
#import "DoingCommentTableViewCell.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "DoingCeremoneyHeaderView.h"

@interface DoingCeremonyViewController ()
{
    int mark ;
}

@property (nonatomic,retain) NSMutableArray *articles;

@property (nonatomic,retain) NSMutableArray *date;

@end

@implementation DoingCeremonyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //    NSLog(@"%@",self.doingKey);
    mark = 1;
    [ self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
    [self.tableView setHeaderHidden:NO];//隐藏头部刷新控件
    
    
    self.date = [NSMutableArray array];
    [self initHeader];
    
    [self dateUrl:mark];
    
    
}

-(void)initHeader
{
    CGSize screenSize =[UIScreen mainScreen].bounds.size ;
    UIView *headerView =  [[UIView alloc]init];
    
    UIImageView *imageView = [UIImageView new];//头部图片，焦点图
    [headerView addSubview:imageView];
    
    // CGFloat ratio  = 300.0f / 320.0f;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenSize.width, screenSize.width));//设置宽高
        make.centerX.equalTo(imageView.superview);//针对父容器剧中
        make.top.equalTo(imageView.superview);//.offset(5);//距离头部距离5个位置
    }];
    
    
    [imageView setImageWithURL:[NSURL URLWithString:[self.doingKey objectForKey:@"memorialthumb"]] placeholderImage:[UIImage imageNamed:@"defaults"]];
    
    DoingCeremoneyHeaderView *mainView = [[[NSBundle mainBundle] loadNibNamed:@"DoingCeremoneyHeaderView" owner:self options:nil] lastObject];
    
    
    [headerView addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom);//设置在imageview的下面
        make.left.right.equalTo(mainView.superview);//设置左右约束
        //make.bottom.equalTo(mainView.superview);
        
    }];
    
    
    mainView.contentLabel.text = [self.doingKey objectForKey:@"memorialintro"];
    mainView.dianzhuLabel.text = [NSString stringWithFormat:@"总共被点过%@次",[self.doingKey objectForKey:@"memorialdianzhu"]];
    mainView.xianhuaLabel.text = [NSString stringWithFormat:@"总共献花%@次",[self.doingKey objectForKey:@"memorialxianhua"]];
    mainView.commentLabel.text = [NSString stringWithFormat:@"评论%@条",[self.doingKey objectForKey:@"count"]];
    
    [mainView.dianzhuBtn addTarget:self action:@selector(dianzhu) forControlEvents:UIControlEventTouchUpInside];
    [mainView.xianhuaBtn addTarget:self action:@selector(xianhua) forControlEvents:UIControlEventTouchUpInside];
    
    [mainView layoutIfNeeded];
    [headerView layoutIfNeeded];//刷新约束
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    
    CGRect rect = [mainView.contentLabel.text boundingRectWithSize:CGSizeMake(screenSize.width - 16.0f, CGFLOAT_MAX)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:attributes
                                                           context:nil];
    
    CGFloat height = imageView.layer.bounds.size.height + 150 + rect.size.height;
    
    
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    self.tableView.tableHeaderView = headerView;//添加header
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
    
    NSLog(@"%@",date);
    
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
    NSLog(@"我是预留数组的总数   %d",self.articles.count);
    if (self.articles.count >0) {
        for (int i =0; i < self.articles.count; i++) {
            id dic = [self.articles objectAtIndex:i];
            [self.date addObject:dic];//[self.articles objectAtIndex:i]];
        }
        
        [ self.tableView reloadData];
    }
    
    NSLog(@"我是加载后的总数   %d",self.date.count);
    [ self.tableView footerEndRefreshing];
}


-(IBAction)DoingCeremonyBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *doing_cell_comment = @"doing_cell_comment";
    
    DoingCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_comment];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCommentTableViewCell" owner:self options:nil]lastObject];
    }
    
    
    NSDictionary *dic = [self.date objectAtIndex:indexPath.row];
    
    cell.phoneLabel.text = [dic objectForKey:@"phone"];
    cell.timeLabel.text = [dic objectForKey:@"created"];
    cell.contentLabel.text = [dic objectForKey:@"message"];
    
    return cell;
}

//点烛
-(void)dianzhu
{
    [self getUrl:0];
}
//献花
-(void)xianhua
{
    [self getUrl:1];
}

//献花或者点烛
//key:0点烛   1：献花
-(void)getUrl:(int)key
{
    NSString *url ;
    if (key == 0) {
        url = [NSString stringWithFormat:@"%@%@",DATE_GET_DIANZHU,[self.doingKey objectForKey:@"id"]];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@%@",DATE_GET_XIANHUA,[self.doingKey objectForKey:@"id"]];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

//设置单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.date.count;
}
//设置分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    return [self heightForBasicCellAtIndexPath:indexPath];
    
    
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static DoingCommentTableViewCell *commentCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        commentCell = [self.tableView dequeueReusableCellWithIdentifier:@"FriendTribalCell"];
    });
    
    return [self calculateHeightForConfiguredSizingCell:commentCell];
    
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}







-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    //[push setValue:sender forKey:@"doingApplyKey"];
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

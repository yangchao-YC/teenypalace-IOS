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
    NSLog(@"%@",self.doingKey);
    mark = 1;
    [ self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
    [self.tableView setHeaderHidden:NO];//隐藏头部刷新控件
    
    
    [self dateUrl:mark];
    
}

//加载更多执行
-(void)footerRereshing
{
    if (self.date.count/(mark +1) == 5) {
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
 key:YES为下啦刷新   NO为加载更多
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
       // [self dateHandle:key];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [SVProgressHUD showInfoWithStatus:errorString maskType:2];//异常提示
        // NSLog(@"Error: %@", error);
    }];
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
    if (indexPath.section == 0) {
        static NSString *doing_cell_ceremony_top = @"doing_cell_ceremony_top";
        
        DoingCeremonyTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_ceremony_top];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCeremonyTopTableViewCell" owner:self options:nil]lastObject];
        }
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:[self.doingKey objectForKey:@"memorialthumb"]] placeholderImage:[UIImage imageNamed:@"defaults"]];
        
        return cell;
    }
    else if(indexPath.section == 1)
    {
        static NSString *doing_cell_ceremony_content = @"doing_cell_ceremony_content";

        DoingCeremonyContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_ceremony_content];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCeremonyContentTableViewCell" owner:self options:nil]lastObject];
        }
        
        cell.contentLabel.text = [self.doingKey objectForKey:@"memorialintro"];
        cell.dianzhuLabel.text = [NSString stringWithFormat:@"总共被点过%@次",[self.doingKey objectForKey:@"memorialdianzhu"]];
        cell.xianhuaLabel.text = [NSString stringWithFormat:@"总共献花%@次",[self.doingKey objectForKey:@"memorialxianhua"]];
        cell.commentLabel.text = [NSString stringWithFormat:@"评论%@条",[self.doingKey objectForKey:@"count"]];
        
        [cell.dianzhuBtn addTarget:self action:@selector(dianzhu) forControlEvents:UIControlEventTouchUpInside];
        [cell.xianhuaBtn addTarget:self action:@selector(xianhua) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        static NSString *doing_cell_comment = @"doing_cell_comment";

        DoingCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_comment];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCommentTableViewCell" owner:self options:nil]lastObject];
        }
        return cell;
    }
    
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
    switch (section) {//根据分区设置单元格
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.articles.count;
            break;
        default:
            break;
    }
    return self.articles.count;
}
//设置分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
    
    if (indexPath.section == 0) {
        return 270;
    }
    else
    {
        if (IOS8_OR_LATER)
        {
            return UITableViewAutomaticDimension;
        }
        return [self heightForBasicCellAtIndexPath:indexPath];

    }
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        static DoingCeremonyContentTableViewCell *contentCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            contentCell = [self.tableView dequeueReusableCellWithIdentifier:@"FriendTribalCell"];
        });
        
      //  [self configureBasicCell:contentCell atIndexPath:indexPath];
        return [self calculateHeightForConfiguredSizingCell:contentCell];
    }
    else
    {
        static DoingCommentTableViewCell *commentCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            commentCell = [self.tableView dequeueReusableCellWithIdentifier:@"FriendTribalCell"];
        });
        
      //  [self configureBasicCell:commentCell atIndexPath:indexPath];
        return [self calculateHeightForConfiguredSizingCell:commentCell];
    }
    
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

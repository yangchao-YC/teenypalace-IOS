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

@end

@implementation DoingCeremonyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.doingKey);
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
    if (indexPath.row == 0) {
         static NSString *doing_cell_ceremony_top = @"doing_cell_ceremony_top";
        
        DoingCeremonyTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_ceremony_top];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCeremonyTopTableViewCell" owner:self options:nil]lastObject];
        }
         return cell;
    }
    else if(indexPath.row == 1)
    {
        static NSString *doing_cell_ceremony_content = @"doing_cell_ceremony_content";

        DoingCeremonyContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doing_cell_ceremony_content];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DoingCeremonyContentTableViewCell" owner:self options:nil]lastObject];
        }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}


#pragma mark 计算cell高度
//神坑啊
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 210;
    }
    
    if (IOS8_OR_LATER)
    {
        
        return UITableViewAutomaticDimension;
    }
    
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
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

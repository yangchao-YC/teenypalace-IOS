//
//  DoingCommentTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/4/23.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoingCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

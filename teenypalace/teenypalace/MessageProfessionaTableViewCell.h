//
//  MessageProfessionaTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/1/29.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageProfessionaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;

@end

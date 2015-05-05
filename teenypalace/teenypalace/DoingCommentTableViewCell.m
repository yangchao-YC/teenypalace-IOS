//
//  DoingCommentTableViewCell.m
//  teenypalace
//
//  Created by 杨超 on 15/4/23.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "DoingCommentTableViewCell.h"

@implementation DoingCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (!IOS8_OR_LATER) {
        self.contentLabel.preferredMaxLayoutWidth = screenWidth - 16.0f;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ApplyClassTableViewCell.m
//  teenypalace
//
//  Created by 杨超 on 14/12/9.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "ApplyClassTableViewCell.h"

@implementation ApplyClassTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //兼容ios7 label自动换行的问题
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (!IOS8_OR_LATER) {
        self.timeLabel.preferredMaxLayoutWidth = screenWidth - 130.0f;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

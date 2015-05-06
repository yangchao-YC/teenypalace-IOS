//
//  DoingBookHeaderView.m
//  teenypalace
//
//  Created by 杨超 on 15/5/6.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "DoingBookHeaderView.h"

@implementation DoingBookHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    //兼容ios7 label自动换行的问题
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (!IOS8_OR_LATER) {
        self.contentLabel.preferredMaxLayoutWidth = screenWidth - 16.0f;
    }
}

@end

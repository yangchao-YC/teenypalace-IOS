//
//  MyMoneyTableViewCell.m
//  teenypalace
//
//  Created by 杨超 on 15/1/19.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "MyMoneyTableViewCell.h"

@implementation MyMoneyTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       // [self creat];
    }
    return self;
}

- (void)creat{
    if (m_checkImageView == nil)
    {
        m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"money_no"]];
        m_checkImageView.frame = CGRectMake(8, 40, 30, 30);
        [self addSubview:m_checkImageView];
    }
}


- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        self.checkBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_yes"]];
     //   self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        self.checkBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"money_no"]];
        // self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

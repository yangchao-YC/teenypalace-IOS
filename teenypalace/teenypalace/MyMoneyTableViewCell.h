//
//  MyMoneyTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/1/19.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMoneyTableViewCell : UITableViewCell
{
    BOOL m_checked;
    UIImageView*	m_checkImageView;
}

- (void)setChecked:(BOOL)checked;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *numbelLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

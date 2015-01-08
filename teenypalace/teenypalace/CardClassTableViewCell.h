//
//  CardClassTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/1/7.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;

@end

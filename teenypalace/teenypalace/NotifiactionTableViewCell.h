//
//  NotifiactionTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 16/3/2.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifiactionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Label_Title;
@property (weak, nonatomic) IBOutlet UILabel *Label_Time;
@property (weak, nonatomic) IBOutlet UILabel *Label_Content;

@end

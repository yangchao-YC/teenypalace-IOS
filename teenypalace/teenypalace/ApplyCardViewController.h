//
//  ApplyCardViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyCardTableViewCell.h"
@interface ApplyCardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(strong,nonatomic)NSString *applyCardKey;

@end

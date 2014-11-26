//
//  ApplyViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/11/17.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyTableViewCell.h"
@interface ApplyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

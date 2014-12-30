//
//  MyCardViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTableViewCell.h"

@interface MyCardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

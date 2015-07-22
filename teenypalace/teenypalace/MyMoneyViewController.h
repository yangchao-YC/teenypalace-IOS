//
//  MyMoneyViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/23.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyMoneyTableViewCell.h"

@interface MyMoneyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sumMoneyBtn;
@property (weak, nonatomic) IBOutlet UILabel *sumMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;



@end

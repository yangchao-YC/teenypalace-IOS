//
//  ApplyClassViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/9.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyClassTableViewCell.h"


@interface ApplyClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)NSDictionary *applyClassKey;
@end

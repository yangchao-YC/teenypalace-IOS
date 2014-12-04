//
//  ApplyProfessionalViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/11/26.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface ApplyProfessionalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSString *applyKey;

@end

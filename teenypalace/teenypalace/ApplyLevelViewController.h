//
//  ApplyLevelViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/8.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyTableViewCell.h"

#import "AFNetworking.h"
@interface ApplyLevelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)NSString *applyProfessionalKey;

@end

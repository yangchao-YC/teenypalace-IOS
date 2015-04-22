//
//  DoingCeremonyViewController.h
//  teenypalace
//
//  Created by 杨超 on 15/3/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoingCeremonyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSDictionary *doingKey;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

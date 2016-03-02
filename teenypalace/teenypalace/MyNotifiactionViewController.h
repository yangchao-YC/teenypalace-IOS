//
//  MyNotifiactionViewController.h
//  teenypalace
//
//  Created by 杨超 on 16/3/2.
//  Copyright © 2016年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNotifiactionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  Doing.h
//  teenypalace
//
//  Created by 杨超 on 15/1/24.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrettyOne: UIView


@property(nonatomic,strong)UITableView *tableView;

@property(copy)void(^PrettyBlock)(NSDictionary *a);

-(void)start;

@end

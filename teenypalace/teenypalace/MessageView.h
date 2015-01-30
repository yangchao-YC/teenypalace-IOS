//
//  MessageView.h
//  teenypalace
//
//  Created by 杨超 on 15/1/29.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView

@property(nonatomic,strong)UITableView *tableView;

@property(copy)void(^MessageBlock)(int a);


@end

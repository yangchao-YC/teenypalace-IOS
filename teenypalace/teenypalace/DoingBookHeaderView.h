//
//  DoingBookHeaderView.h
//  teenypalace
//
//  Created by 杨超 on 15/5/6.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoingBookHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

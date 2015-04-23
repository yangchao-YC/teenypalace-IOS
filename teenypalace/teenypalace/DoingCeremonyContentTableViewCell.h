//
//  DoingCeremonyContentTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/4/23.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoingCeremonyContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dianzhuBtn;
@property (weak, nonatomic) IBOutlet UIButton *xianhuaBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *xianhuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

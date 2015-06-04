//
//  ApplyClassDetailsViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyAlertView.h"
#import "LoginViewController.h"
@interface ApplyClassDetailsViewController : UIViewController


@property(strong,nonatomic)NSDictionary *applyDetailsKey;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageSLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageELabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *discountLabel;


@end

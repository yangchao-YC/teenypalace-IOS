//
//  MyClassDetailsViewController.h
//  teenypalace
//
//  Created by 杨超 on 15/1/7.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClassDetailsViewController : UIViewController


@property(strong,nonatomic)NSDictionary *MyClassDetailsKey;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeBeginLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeEndLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sumTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

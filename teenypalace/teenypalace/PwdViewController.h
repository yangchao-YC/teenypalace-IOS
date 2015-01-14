//
//  PwdViewController.h
//  teenypalace
//
//  Created by 杨超 on 15/1/8.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdViewController : UIViewController<UITextFieldDelegate>


@property(strong,nonatomic)NSDictionary *pwdKey;

@property (weak, nonatomic) IBOutlet UITextField *pwdOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTwoTextField;
@property (weak, nonatomic) IBOutlet UIButton *pwdBtn;

@end

//
//  LoginViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/11/5.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMoneyViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginCheckBox;
@property (weak, nonatomic) IBOutlet UIImageView *CheckImage;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
+ (void)logOut;

+(void)addTag;
@end

//
//  DoingApplyViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/8.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoingApplyViewController : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic)NSString *doingApplyKey;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *siteTextField;

@end

//
//  MyNewCardViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/26.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewCardViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)NSString *MyNewKey;

@property(copy)void(^NewCardBlock)(void);

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *manImage;
@property (weak, nonatomic) IBOutlet UIImageView *womanImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

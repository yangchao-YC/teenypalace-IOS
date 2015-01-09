//
//  InformationProcessingViewController.h
//  teenypalace
//
//  Created by 杨超 on 15/1/8.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationProcessingViewController : UIViewController<UITextFieldDelegate>
{
    NSTimer *timer;
    int time;//计算定时器时间
    BOOL timeStart;//判断时候已经启动定时器
}
@property(strong,nonatomic)NSString *InformationProcessingKey;//接收上级页面信息，0为忘记密码，1为注册新用户
@property (weak, nonatomic) IBOutlet UILabel *tabbarLabel;//导航栏名称
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//手机号码输入框
@property (weak, nonatomic) IBOutlet UITextField *identifyTextField;//验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *identifyBtn;//验证码按钮


@end

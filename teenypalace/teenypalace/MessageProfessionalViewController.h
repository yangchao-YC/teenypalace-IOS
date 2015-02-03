//
//  MessageProfessionalViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageProfessionalViewController : UIViewController


@property(strong,nonatomic)NSDictionary *applyProfessionalKey;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView0;
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UIView *bgView3;
@property (weak, nonatomic) IBOutlet UIView *bgView4;

@property (weak, nonatomic) IBOutlet UIWebView *viewWeb0;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb1;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb2;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb3;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb4;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight4;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
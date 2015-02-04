//
//  PrettyWebViewController.h
//  teenypalace
//
//  Created by 杨超 on 15/2/4.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@interface PrettyWebViewController : UIViewController

@property(strong,nonatomic)NSDictionary *PrettyKey;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *tabbarLabel;

@end

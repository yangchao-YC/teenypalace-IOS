//
//  MessageWebViewController.h
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tabbarLabel;
@property(strong,nonatomic)NSDictionary *applyProfessionaKey;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

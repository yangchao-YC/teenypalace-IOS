//
//  ApplyAlertView.h
//  teenypalace
//
//  Created by 杨超 on 14/12/11.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyAlertView : UIView


- (id)initWithView:(UIView *)view title:(NSString *)title;
- (void)show;
- (void)hide;

@property(copy)void(^ApplyCardBlock)(int a);


@end

















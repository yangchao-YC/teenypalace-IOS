//
//  ApplyAlertView.m
//  teenypalace
//
//  Created by 杨超 on 14/12/11.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "ApplyAlertView.h"
#import "ApplyCardViewController.h"

@interface ApplyAlertView()
{
    CGFloat x;
    CGFloat y;
}

@property(nonatomic,strong)UIView *bg_one_view;//黑色底层view--第一底层
@property(nonatomic,strong)UIView *bg_view;//白色底层view--第二底层

@property(nonatomic,strong)UILabel *titleLabel;//标题

@property(nonatomic,strong)UIButton *ok_btn;//确定按钮

@property(nonatomic,strong)UIButton *no_btn;//否定按钮

@end



@implementation ApplyAlertView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(id)initWithView:(UIView *)view title:(NSString *)title
{
    
    //UIColor *color = [UIColor colorWithRed:26.0f/255.0f green:110.0f/255.0f blue:22.0f/255.0f alpha:1.0f];
    UIFont *titleFont = [UIFont fontWithName:@"ARIAL" size:14.0f];
    
    
    self = [self initWithFrame:view.frame];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
    
    self.bg_one_view = [[UIView alloc]init];

    x = (view.frame.size.width - 252)/2;
    y = (view.frame.size.height -122)/2;
    
    self.bg_one_view.frame = CGRectMake(x, y, 252, 122);
    self.bg_one_view.backgroundColor = [UIColor blackColor];
    
    
    [self addSubview:self.bg_one_view];
    
    self.bg_view = [[UIView alloc]init];
    self.bg_view.frame = CGRectMake(1, 1, 250, 120);
    self.bg_view.backgroundColor = [UIColor whiteColor];
    [self.bg_one_view addSubview:self.bg_view];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, 250, 21)];
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = titleFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [self.bg_view addSubview:self.titleLabel ];
    
    
    self.ok_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ok_btn.frame = CGRectMake(66, 82, 46, 20);
    [self.ok_btn setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:133.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    
    [self.ok_btn setAdjustsImageWhenHighlighted:NO];
    [self.ok_btn addTarget:self action:@selector(bark) forControlEvents:UIControlEventTouchUpInside];
    [self.ok_btn setTitle:@"是" forState:UIControlStateNormal];
    self.ok_btn.titleLabel.font = titleFont;
    self.ok_btn.tag = 0;
    [self.bg_view addSubview:self.ok_btn];
    
    self.ok_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ok_btn.frame = CGRectMake(138, 82, 46, 20);
    [self.ok_btn setBackgroundColor:[UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1.0f]];
    
    [self.ok_btn setAdjustsImageWhenHighlighted:NO];
    [self.ok_btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.ok_btn setTitle:@"否" forState:UIControlStateNormal];
    self.ok_btn.titleLabel.font = titleFont;
    self.ok_btn.tag = 1;
    [self.bg_view addSubview:self.ok_btn];
    
    return self;
}




-(void)show
{
    self.bg_view.clipsToBounds = YES;
    CGAffineTransform newTransform = CGAffineTransformScale(self.bg_view.transform, 0.1, 0.1);
    [[[[UIApplication sharedApplication]windows]objectAtIndex:0]addSubview:self];
    [UIView beginAnimations:@"imageViewBig" context:nil];
    [UIView setAnimationDuration:.3f];
    
    
    
    newTransform = CGAffineTransformConcat(self.bg_view.transform,  CGAffineTransformInvert(self.bg_view.transform));
    [self.bg_view setTransform:newTransform];
    [UIView commitAnimations];
}

- (void)hide
{
    [self removeFromSuperview];
}

-(void)bark
{
   // [self hide];
/*
    ApplyCardViewController *applyCard = [[ApplyCardViewController alloc]init];
    [applyCard ApplyCardBlock:^{
        
    }];
    */
    self.ApplyCardBlock(1);
    
}



@end






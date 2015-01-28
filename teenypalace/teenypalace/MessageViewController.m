//
//  MessageViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//招生信息预览


#import "MessageViewController.h"
#import "DoingOne.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);//如果没有导航栏，则去掉64
    
    //对应填写两个数组
    NSArray *views =@[[DoingOne new],[DoingOne new]];   //创建使用
    NSArray *names =@[@" 项目介绍 ",@" 名师简介 "];
    self.scrollNav =[XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:names withThreeAnimation:222];//三中动画都选择
    self.scrollNav.backgroundColor = [UIColor clearColor];
    //自定义各种属性。。打开查看
    // self.scrollNav.xl_topBackImage =[UIImage imageNamed:@"tabbar_bg"];
    self.scrollNav.xl_topBackColor =[UIColor clearColor];
    self.scrollNav.xl_sliderColor = [UIColor whiteColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"baidi"]];//[UIColor whiteColor];//选中背景框
    self.scrollNav.xl_buttonColorNormal =[UIColor whiteColor];//未选中字体颜色
    self.scrollNav.xl_buttonColorSelected =[UIColor colorWithRed:255.0f/255.0f green:132.0f/255.0f blue:0.0f/255.0f alpha:1];//选中字体颜色
    self.scrollNav.xl_buttonFont =14;
    self.scrollNav.xl_buttonToSlider =30;
    self.scrollNav.xl_sliderHeight =35;//滑块高度
    self.scrollNav.xl_topHeight =35;
    self.scrollNav.xl_sliderCorner = 7;
    self.scrollNav.xl_isSliderCorner =YES;
    
    //加入控制器视图
    [self.view addSubview:self.scrollNav];

    
    self.scrollNav.XlScrollBlock = ^(int a)
    {
        NSLog(@"%d",a);
    };
    
}





-(IBAction)MessageBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            
            break;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

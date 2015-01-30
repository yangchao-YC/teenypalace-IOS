//
//  DoingViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/4.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//公益活动

#import "DoingViewController.h"

#import "DoingOne.h"
#import "DoingTwo.h"
#import "DoingZero.h"
#import "DoingThree.h"
@interface DoingViewController ()
{
    BOOL oneIndex;
    BOOL twoIndex;
    BOOL threeIndex;
}




@end

@implementation DoingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);//如果没有导航栏，则去掉64
    
    //对应填写两个数组
    NSArray *views =@[[DoingZero new],[DoingOne new],[DoingTwo new],[DoingThree new],[DoingThree new],[DoingThree new],[DoingThree new],[DoingThree new]];   //创建使用
    NSArray *names =@[@" 团队活动 ",@" 主题活动 ",@" 小时候活动 ",@" 小时候艺术 ",@" 小时候艺术 ",@" 小时候艺术 ",@" 小时候艺术 ",@" 小时候艺术 "];
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

    
    oneIndex = YES;
    twoIndex = YES;
    threeIndex = YES;
    DoingZero *vv0 = views[0];
    DoingOne *vv1 = views[1];
    DoingTwo *vv2 = views[2];
    DoingThree *vv3 = views[3];
    
    [vv0 start];
    
    self.scrollNav.XlScrollBlock = ^(int a)
    {
        switch (a) {
            case 1:
                if (oneIndex) {
                    [vv1 start];
                    oneIndex = NO;
                }
                break;
            case 2:
                if (twoIndex) {
                    [vv2 start];
                    twoIndex = NO;
                }
                break;
            case 3:
                if (threeIndex) {
                    [vv3 start];
                    threeIndex = NO;
                }
                break;

            default:
                break;
        }
    };
    //回调跳转
    vv0.DoingBlock = ^(NSDictionary *a)
    {
        [self performSegueWithIdentifier:@"doing_doingDetails" sender:a];
    };
    vv1.DoingBlock = ^(NSDictionary *a)
    {
        [self performSegueWithIdentifier:@"doing_doingDetails" sender:a];
    };
    vv2.DoingBlock = ^(NSDictionary *a)
    {
        [self performSegueWithIdentifier:@"doing_doingDetails" sender:a];
    };
    vv3.DoingBlock = ^(NSDictionary *a)
    {
        [self performSegueWithIdentifier:@"doing_doingDetails" sender:a];
    };
    
}





-(IBAction)DoingBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"doingKey"];
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

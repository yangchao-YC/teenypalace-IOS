//
//  PrettyViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/20.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//美丽青宫

#import "PrettyViewController.h"

#import "PrettyZero.h"
#import "PrettyOne.h"
#import "PrettyTwo.h"
#import "PrettyThree.h"
#import "PrettyFour.h"
@interface PrettyViewController ()
{
    BOOL oneIndex;
    BOOL twoIndex;
    BOOL threeIndex;
    BOOL fourIndex;
}
@end

@implementation PrettyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);//如果没有导航栏，则去掉64
    
    //对应填写两个数组
    NSArray *views =@[[PrettyZero new],[PrettyOne new],[PrettyTwo new],[PrettyThree new],[PrettyFour new]];   //创建使用
    NSArray *names =@[@" 本宫简介 ",@" 工作动态 ",@" 媒体聚焦 ",@" 部门社区 ",@"  平面图  "];
    self.scrollNav =[XLScrollViewer scrollWithFrame:frame withViews:views withButtonNames:names withThreeAnimation:222];//三中动画都选择
    self.scrollNav.backgroundColor = [UIColor clearColor];
    //自定义各种属性。。打开查看
    // self.scrollNav.xl_topBackImage =[UIImage imageNamed:@"tabbar_bg"];
    self.scrollNav.xl_topBackColor =[UIColor clearColor];
    self.scrollNav.xl_sliderColor = [UIColor whiteColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"baidi"]];//[UIColor whiteColor];//选中背景框
    self.scrollNav.xl_buttonColorNormal =[UIColor whiteColor];//未选中字体颜色
    self.scrollNav.xl_buttonColorSelected =[UIColor colorWithRed:255.0f/255.0f green:132.0f/255.0f blue:0.0f/255.0f alpha:1];//选中字体颜色
    self.scrollNav.xl_buttonFont =12;
    self.scrollNav.xl_buttonToSlider =30;
    self.scrollNav.xl_sliderHeight =35;//滑块高度
    self.scrollNav.xl_topHeight =35;
    self.scrollNav.xl_sliderCorner = 5;
    self.scrollNav.xl_isSliderCorner =YES;
    
    //加入控制器视图
    [self.view addSubview:self.scrollNav];
    

    
    
    oneIndex = YES;
    twoIndex = YES;
    threeIndex = YES;
    fourIndex = YES;
    PrettyOne *vv1 = views[1];
    PrettyTwo *vv2 = views[2];
    PrettyThree *vv3 = views[3];
    PrettyFour *vv4 = views[4];
    
    
    self.scrollNav.XlScrollBlock = ^(int a)
    {
        NSLog(@"%d",a);
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
            case 4:
                if (fourIndex) {
                    [vv4 start];
                    fourIndex = NO;
                }
                break;
            default:
                break;
        }
    };
    //回调跳转

    vv1.PrettyBlock = ^(NSDictionary *a)
    {
        NSString *url = [NSString stringWithFormat:@"%@%@",DATE_PRETTY_SUM,[a objectForKey:@"id"]];
        [self sumUrl:url];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"key",@"工作动态",@"title", [a objectForKey:@"field_news_events_body"],@"body",[a objectForKey:@"id"],@"id",nil];
        [self performSegueWithIdentifier:@"pretty_prettyWeb" sender:dic];
    };
    vv2.PrettyBlock = ^(NSDictionary *a)
    {
        
        NSString *url = [NSString stringWithFormat:@"%@%@",DATE_PRETTY_SUM,[a objectForKey:@"id"]];
        [self sumUrl:url];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"key",@"媒体聚焦",@"title", [a objectForKey:@"field_news_events_body"],@"body",[a objectForKey:@"id"],@"id",nil];
        [self performSegueWithIdentifier:@"pretty_prettyWeb" sender:dic];
    };
    vv3.PrettyBlock = ^(NSDictionary *a)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"key",[a objectForKey:@"body"],@"body", [a objectForKey:@"title"],@"title",nil];
        [self performSegueWithIdentifier:@"pretty_prettyWeb" sender:dic];
    };
    
    
    
}


-(void)sumUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *push = segue.destinationViewController;
    [push setValue:sender forKey:@"PrettyKey"];
}


-(IBAction)PrettyBtn:(UIButton *)sender
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

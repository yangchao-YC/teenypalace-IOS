//
//  DoingViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/4.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

//公益活动

#import "DoingViewController.h"

#import "View2.h"
#import "Doing.h"
@interface DoingViewController ()

@end

@implementation DoingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    // [self.tableView addHeaderWithTarget:self action:@selector(headerrereshing)];//绑定MJ刷新头部
    
    //  [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];//绑定MJ刷新尾部
    
    
    //[self.tableView headerBeginRefreshing];//自动执行下啦刷新
    //[self.tableView footerBeginRefreshing];
    CGRect frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64);//如果没有导航栏，则去掉64
    
    //对应填写两个数组
    NSArray *views =@[[View2 new],[View2 new],[View2 new],[View2 new]];   //创建使用
    NSArray *names =@[@" 团队活动 ",@" 主题活动 ",@" 小时候活动 ",@" 小时候艺术 "];
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
    
}

//下拉刷新执行
-(void)headerrereshing
{
    [self.tableView reloadData];//将数据放入数组后填入tableview
    [self.tableView headerEndRefreshing];
}

//加载更多执行
-(void)footerRereshing
{
    
    [self.tableView reloadData];//将数据放入数组后填入tableview
    [self.tableView footerEndRefreshing];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    
    static NSString *apply_cell_id = @"apply_cell_id";
    
   // ApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:apply_cell_id];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
*/
    
    return nil;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//设置显示行数
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;//设置为只有一个模块
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




-(IBAction)DoingBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            [self performSegueWithIdentifier:@"doing_doingDetails" sender:@"yy"];
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

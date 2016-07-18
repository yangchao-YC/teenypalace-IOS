//
//  HomeViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/11/10.
//  Copyright (c) 2014年 杨超. All rights reserved.
//



//主页面


#import "HomeViewController.h"
#import "MyNotifiactionViewController.h"
@interface HomeViewController ()
{
    BOOL checkBox ;
    CGRect ScreenSize;
    NSString *UpdateUrl;
}

@end

@implementation HomeViewController



+(void)push
{
    NSLog(@"通知回调");
    //LoginViewController *view = [[LoginViewController alloc]init];
    //[view pushs:dic];
    /*
     id instance = [[MyNotifiactionViewController alloc]init];
     // 获取导航控制器
     UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
     UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
     // 跳转到对应的控制器
     [pushClassStance pushViewController:instance animated:YES];
     */
    
    // HomeViewController *view = [[HomeViewController alloc] init];
    // [view push];
    
    NSNotification *notification = [NSNotification notificationWithName:@"notifiction_push" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

-(void)pushs
{
    // MyNotifiactionViewController *view = [[MyNotifiactionViewController alloc]init];
    // [self.navigationController pushViewController:view animated:YES];
    
    @try {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MyNotifiactionViewController *controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MyNotifiactionViewController"];
        
        [self showViewController:controller sender:nil];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
    // [self performSegueWithIdentifier:@"home_notifiaction" sender:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //首先应该检查是否登录了。没登录就弹出登录界面
    // [self performSelector:@selector(gotoLogin) withObject:self afterDelay:.1f];
    
    
    
    // ScreenSize = [UIScreen mainScreen].bounds;//获取屏幕尺寸
    
    //[self performSegueWithIdentifier:@"home_notifiaction" sender:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushs) name:@"notifiction_push" object:nil];//接收通知，用于支付完成回调
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [self Update];
    
    NSString *ns = [user stringForKey:@"push"];
    if ([ns isEqual:@"push"]) {
        [self performSegueWithIdentifier:@"home_notifiaction" sender:nil];
    }
    else
    {
        //  YLLAccountManager *accountManager = [YLLAccountManager sharedAccountManager];
        NSString *login = [user stringForKey:@"loginOK"];
        if ([YLLAccountManager sharedAccountManager].f_isLogined) {
            
            return;
        }
        [self performSelector:@selector(logout) withObject:self afterDelay:.5f];
    }
    
    
    
}


/*检查更新*/
-(void)Update
{
    NSString *url = @"http://itunes.apple.com/lookup?id=1003716406";
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    //  requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [requestManager POST:url parameters:
     @{
       }success:^(AFHTTPRequestOperation *operation, id responseObject) {
           // NSLog(@"JSON: %@", responseObject);
           
           NSMutableArray *date = [NSMutableArray arrayWithArray:[responseObject objectForKey:@"results"]];
           NSDictionary *dic = [date objectAtIndex:0];
           //  NSLog(@"我是版本号:%@",[dic objectForKey:@"version"]);
           
           
           NSDictionary *info = [[NSBundle mainBundle]infoDictionary];
           NSString *appVersion = [info objectForKey:@"CFBundleShortVersionString"];
           
           //  NSLog(@"我是版本号2:%@",appVersion);
           
           if ([appVersion floatValue] < [[dic objectForKey:@"version"] floatValue]) {
               UpdateUrl = [NSString stringWithFormat:@"%@", [dic objectForKey:@"trackViewUrl"],nil];
               
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本%@", [dic objectForKey:@"version"],nil]  message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"releaseNotes"],nil] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
               [alertView show];
           }
           
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
       }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UpdateUrl]];
    }
}


//这个方法只弹出登录界面
- (void)logout
{
    [LoginViewController logOut];
}



- (void)gotoLogin
{
    [self.navigationController performSegueWithIdentifier:@"LoginNav" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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

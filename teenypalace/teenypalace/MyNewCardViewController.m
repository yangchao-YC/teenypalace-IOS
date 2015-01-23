//
//  MyNewCardViewController.m
//  teenypalace
//
//  Created by 杨超 on 14/12/26.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "MyNewCardViewController.h"
#import "ZHPickView.h"
@interface MyNewCardViewController ()<ZHPickViewDelegate>
{
    NSString *sexString;//1为男，2为女
    NSString *nameString;//学员姓名
    NSString *timeString;//出生年月
    NSString *phoneString;//联系方式
    NSString *cardString;//学员卡号
    
}
@property(nonatomic,strong)ZHPickView *pickview;
@property (nonatomic,retain) NSDictionary *dic;

@end

@implementation MyNewCardViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sexString = @"1";
    
    if ([self.MyNewKey isEqualToString:@"1"]) {
        self.sexLabel.hidden = YES;
        self.sexView.hidden = YES;
        self.dateBtn.hidden = YES;
        self.dateLabel.hidden = YES;
        self.cardTextField.placeholder = @"请输入卡号：";
        NSLayoutConstraint *topOK = [NSLayoutConstraint constraintWithItem:self.okBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sexView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
        [self.bgView addConstraint:topOK];
    }
    
    
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    
    //点击键盘外区域关闭键盘
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    
}



/*
 报名
 card：学员卡号
 classID：班级ID
 */
-(void)datePost
{
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    id parameters;
    NSString *url;
    /*
     phone 账号
     lastlogintime    最后登陆时间
     field_student_parentsid  家长ID
     field_student_name      学员姓名
     field_student_sex       性别
     field_student_birthday     出生年月
     field_student_contactinfo  联系方式
     */
    
  //  NSLog(@"最后登陆时间：%@    家长ID：%@    电话号码：%@      卡号：%@       姓名：%@" ,app.LastloginTime,app.ParentId,app.UserName,cardString,nameString);

    
    if ([self.MyNewKey isEqualToString:@"1"]) {//旧学员卡
        parameters=  @{@"lastlogintime":app.LastloginTime,
                       @"field_student_parentsid":app.ParentId,
                       @"phone":app.UserName,
                       @"field_student_card":cardString,
                       @"field_student_name":nameString
                       };
        url = DATE_CARD_USED;
    }
    else//新学员卡
    {
        parameters=  @{@"phone":app.UserName,
                       @"lastlogintime":app.LastloginTime,
                       @"field_student_parentsid":app.ParentId,
                       @"field_student_name":nameString,
                       @"field_student_sex":sexString,
                       @"field_student_birthday":timeString,
                       @"field_student_contactinfo":phoneString
                       };
        url = DATE_CARD_NEW;
    }
    
    NSLog(@"%@",parameters);
    
    [requestManager POST:url parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"JSON: %@", responseObject);
           self.dic = responseObject;
           [self dateHandle];
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
           NSString *errorString = [NSString stringWithFormat:@"%@",error];
           [SVProgressHUD showInfoWithStatus:errorString maskType:3];//异常提示
       }];
}

/*
 数据处理
 */
-(void)dateHandle
{
    if ([[self.dic objectForKey:@"status"] intValue] == 0) {
        [SVProgressHUD showSuccessWithStatus:@"添加成功" maskType:3];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:[self.dic objectForKey:@"message"] maskType:3];
    }
    
}




/*
 tag
 0:返回
 1：男
 2：女
 3：出生日期
 4：确定
 */

-(IBAction)MyCardNewBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            self.manImage.image = [UIImage imageNamed:@"radio_true"];
            self.womanImage.image = [UIImage imageNamed:@"radio_false"];
            sexString = @"1";
            break;
        case 2:
            self.manImage.image = [UIImage imageNamed:@"radio_false"];
            self.womanImage.image = [UIImage imageNamed:@"radio_true"];
            sexString = @"2";
            break;
        case 3:
            [self time];
            break;
        case 4:
            [self checkOK];
            break;
    }
    
}

-(void)time
{
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.delegate=self;
    
    [_pickview show];
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    
    
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * na = [df stringFromDate:currentDate];
    
    int time = [self compareDate:[resultString substringToIndex:19] withDate:na];
    if (time == 1) {
        self.dateLabel.text = [resultString substringToIndex:10];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"时间选择错误" maskType:3];
    }
}


-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: //NSLog(@"erorr dates %@, %@", dt2, dt1);
            break;
    }
    return ci;
}

-(void)checkOK
{
    
    NSString *user;
    user = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (user.length>0) {
        NSString *card;
        
        card= [self.cardTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([self.MyNewKey isEqualToString:@"1"]) {//旧学员卡
            if (card.length >=7) {
                
                nameString = user;
                cardString = card;
                [SVProgressHUD showWithStatus:@"正在添加,请稍后..."];
                [self datePost];
                
            }
            else
            {
                [SVProgressHUD showInfoWithStatus:@"学员卡位数不正确" maskType:3];
            }
        }
        else
        {
            if (card.length == 11) {//判断手机号长度
                
                if ([self.dateLabel.text isEqualToString:@"出生日期"]) {
                    [SVProgressHUD showInfoWithStatus:@"请选择出生日期" maskType:3];
                }
                else
                {
                    nameString = user;
                    timeString = [NSString stringWithFormat:@"%@ 00:00:00",self.dateLabel.text] ;
                    phoneString = card;
                    [SVProgressHUD showWithStatus:@"正在添加,请稍后..."];
                    [self datePost];
                }
            }
            else
            {
                [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码" maskType:3];
            }
        }
 
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"姓名不能为空" maskType:3];
    }
        
    

}



//当用户按下return键或者按回车键，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.nameTextField) {
        [self.cardTextField becomeFirstResponder];//使下一个联系方式对话框获取焦点
    }
    else
    {
    
    [textField resignFirstResponder];
    }
    return YES;
}

//关闭键盘
- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

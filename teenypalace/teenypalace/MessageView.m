//
//  MessageView.m
//  teenypalace
//
//  Created by 杨超 on 15/1/29.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "MessageView.h"
#import "MessageProfessionaTableViewCell.h"
#import "Masonry.h"
@interface MessageView()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *array;
}
@end


@implementation MessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        array = [NSMutableArray arrayWithCapacity:5];
        
        [array addObject:@"120"];
        [array addObject:@"120"];
        [array addObject:@"120"];
        [array addObject:@"120"];
        [array addObject:@"120"];
        
        
        
        self.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1];
        
        CGRect Screensize = [UIScreen mainScreen].bounds;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 5, Screensize.size.width -10, Screensize.size.height - 114) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self addSubview: self.tableView];
        
        
        //[array replaceObjectAtIndex:1 withObject:@"130"];//更改指定索引的值
        
        
        
        
    }
    return self;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *message_professiona_cell_id = @"message_professiona_cell_id";
    
    MessageProfessionaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:message_professiona_cell_id];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageProfessionaTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = ART;
            cell.images.image = [UIImage imageNamed:@"message1"];
            cell.contentLabel.text = @"开设了儿童画、素描、书法、国画、等基础培训项目，以亲子课型为主的酷酷熊玩美工场，以低幼段启蒙教育的小小未来创意泥，以多种媒介为主的小魔方大画室，以青少年喜爱的卡通画面为主的恒星动漫梦工厂，以素描为基础的点线面美术工作室和长江画室。";
            break;
        case 1:
            cell.titleLabel.text = LITERARY;
            cell.images.image = [UIImage imageNamed:@"message2"];
            cell.contentLabel.text = @"开设了舞蹈、声乐、器乐、表演四大类培训项目，器乐培训包括钢琴、电子 琴、电钢琴、手风琴、小提琴、萨克斯、长笛、架子鼓、二胡、琵琶、古筝、竹笛等。";
            break;
        case 2:
            cell.titleLabel.text = GYM;
            cell.images.image = [UIImage imageNamed:@"message3"];
            cell.contentLabel.text = @"开设了体育舞蹈（拉丁舞、摩登舞）、街舞、兵兵球、跆拳道、围棋、国际象棋、中国象棋、艺术体操、幼儿体操、武术、轮滑、魔术等项目。";
            break;
        case 3:
            cell.titleLabel.text = LANGUAGE;
            cell.images.image = [UIImage imageNamed:@"message4"];
            cell.contentLabel.text = @"开设了青少年语文、数学、外语、科技等兴趣培训，广泛开展英语角、科技夏令营、小记者夏令营、各类竞赛比赛等学科活动。";
            break;
        case 4:
            cell.titleLabel.text = CHILDREN;
            cell.images.image = [UIImage imageNamed:@"message5"];
            cell.contentLabel.text = @"开设了舞蹈团、少儿合唱团、民乐团、表演团等，不定期组织团员开展国内外文化艺术交流。";
            break;
            
        default:
            break;
    }

    [cell.bgBtn addTarget:self action:@selector(tableBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn addTarget:self action:@selector(pushBtn:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}



/*
 点击更换状态
 */
-(IBAction)tableBtnClick:(id)sender event:(id)event
{
   
    NSSet *touches = [event allTouches];//把触摸的事件放到集合里
    UITouch *touch = [touches anyObject];//把事件放到触摸的对象里
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];//把触发的这个点转成二位坐标
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];//匹配坐标点
    if (indexPath != nil) {
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

-(IBAction)pushBtn:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];//把触摸的事件放到集合里
    UITouch *touch = [touches anyObject];//把事件放到触摸的对象里
    
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];//把触发的这个点转成二位坐标
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];//匹配坐标点
    if (indexPath != nil) {
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
}

//按钮的触发方法
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageProfessionaTableViewCell *cell = (MessageProfessionaTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    float wigth = cell.contentLabel.frame.size.width;
    int height = 140;
    
    CGRect Screensize = [UIScreen mainScreen].bounds;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    CGRect rect_content = [cell.contentLabel.text boundingRectWithSize:CGSizeMake(Screensize.size.width - 14.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    
  //   NSLog(@"我是高度%f",rect_content.size.height);

  //  NSLog(@"我是原始高度%f",cell.contentLabel.frame.size.height);
    if (cell.contentLabel.frame.size.height == 25) { //25为xib设计contentLabel的原始高度
        if (rect_content.size.width > wigth) {
            
            height = rect_content.size.height + 120;
            
            /*
             int line = (14 *cell.contentLabel.text.length) / wigth;
             
             
             if(line == 1)
             {
             height =  140 ;
             }
             else
             {
             height = 120 + (line *20);
             }
             
             
             NSLayoutConstraint *widthLabel = [NSLayoutConstraint constraintWithItem:cell.contentLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:height-100];
             
             
             [cell addConstraint:widthLabel];
             
             [cell.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(cell.View_Top).offset(12);
             make.bottom.equalTo(cell.contentLabel.superview);
             make.left.right.equalTo(cell.contentLabel.superview);
             }];
             */
            
            [array replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",height]];//更改指定索引的值
            [self.tableView reloadData];
            
        }
    }
    else
    {
        [array replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",120]];//更改指定索引的值
        [self.tableView reloadData];
    }
    

    
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
    return [[array objectAtIndex:indexPath.row] intValue];
}//设置模块内cell的高度




//下面为点击事件方法


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.MessageBlock(indexPath.row);
}


@end

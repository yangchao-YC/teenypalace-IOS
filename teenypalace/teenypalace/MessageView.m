//
//  MessageView.m
//  teenypalace
//
//  Created by 杨超 on 15/1/29.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import "MessageView.h"
#import "MessageProfessionaTableViewCell.h"

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
            cell.contentLabel.text = @"学习线描画,彩笔画,水粉画,指导儿童画创作";
            break;
        case 1:
            cell.titleLabel.text = LITERARY;
            cell.images.image = [UIImage imageNamed:@"message2"];
            cell.contentLabel.text = @"学习基本乐理知识,学习科学,系统的发声方法";
            break;
        case 2:
            cell.titleLabel.text = GYM;
            cell.images.image = [UIImage imageNamed:@"message3"];
            cell.contentLabel.text = @"对少年儿童的身心健康成长有不可替代的作用";
            break;
        case 3:
            cell.titleLabel.text = LANGUAGE;
            cell.images.image = [UIImage imageNamed:@"message4"];
            cell.contentLabel.text = @"课程全英授课为学生打造地道的英文环境";
            break;
        case 4:
            cell.titleLabel.text = CHILDREN;
            cell.images.image = [UIImage imageNamed:@"message5"];
            cell.contentLabel.text = @"排演优秀的中外少儿舞蹈作品";
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
    
    if (cell.contentLabel.text.length*14 > wigth) {
        
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
        [array replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%d",height]];//更改指定索引的值
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

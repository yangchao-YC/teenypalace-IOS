//
//  MessageTeachreTableViewCell.h
//  teenypalace
//
//  Created by 杨超 on 15/1/30.
//  Copyright (c) 2015年 杨超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTeachreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesHeight;
@property (weak, nonatomic) IBOutlet UIImageView *buttomImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTop;

@end

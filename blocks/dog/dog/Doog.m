//
//  Doog.m
//  dog
//
//  Created by 杨超 on 14/12/13.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import "Doog.h"

@implementation Doog
@synthesize ID = _ID;

-(id)init
{
    self = [super init];
    if (self) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:NO];
    }
    return  self;
}

-(void)setBark:(void(^)(Doog *dog))eachBark
{
    //[PerBlock copy];
}

-(void)updateTimer:(id)arg
{
    NSLog(@"dog   %d    ----   ",_ID);
}
@end

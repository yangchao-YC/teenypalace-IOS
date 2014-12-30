//
//  Doog.h
//  dog
//
//  Created by 杨超 on 14/12/13.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doog : NSObject
{
    int _ID;
    NSTimer *timer;
    int barkCount;
    
    void(^PerBlock)(Doog *dog);
    
}
//向外暴露了一个函数
-(void)setBark:(void(^)(Doog *dog))eachBark;


@property (assign) int ID;





@end

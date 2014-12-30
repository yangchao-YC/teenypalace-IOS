//
//  main.m
//  dog
//
//  Created by 杨超 on 14/12/12.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doog.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Doog * dog= [[Doog alloc] init];
        
        [dog setID:10];
        
        
        
        while (1) {
            [[NSRunLoop currentRunLoop]run];
        }
         
        
    }
    return 0;
}

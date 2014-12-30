//
//  main.m
//  blocks
//
//  Created by 杨超 on 14/12/12.
//  Copyright (c) 2014年 杨超. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int (^SumBlock) (int a, int b);//定义block

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        void(^myblocks)(void) = NULL;
        
        myblocks = ^(void)
        {
            NSLog(@"log");
        };
        
        
        
         NSLog(@"---------");
        
        myblocks();//执行block
        
        NSLog(@"-----");
        
        
        /*
         2014-12-12 16:18:40.671 blocks[1609:461294] log
         */
        
        
        int (^myblock2)(int a,int b) = ^(int a, int b){
            int c = a+b;
            return c;
        };
        int ret = myblock2(10,20);
        
        NSLog(@"block2    %d",ret);
        
        
        
        
        
        __block int sum = 0;
        int (^myblock3)(int a,int b) = ^(int a, int b){
            sum = a + b;
            return sum;
        };
        
        myblock3(20,30);
        
        NSLog(@"sum  -- %d",sum);
        
        
        SumBlock myblocks4 = ^(int a, int b){
            NSLog(@"SumBlock   --   %d",a+b);
            
            return 0;
            
        };
        
        myblocks4(30,30);
        
    }
    return 0;
}

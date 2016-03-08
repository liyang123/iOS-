


//
//  NSOperationViewController.m
//  NSThreadDemo
//
//  Created by ly on 16/3/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self testNSOperation];
//    [self testNSOperationTwo];
}

- (void)testNSOperation {
    // 使用定义好的两个子类
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    operation1.name = @"operation1";
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation %@", [NSThread currentThread]);
    }];
    blockOperation.name = @"blockOperation";
    
    // 把NSOperation子类放入队列中去
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:blockOperation];
    queue.maxConcurrentOperationCount = 2; // 最大并发数
}
- (void)test {
    NSLog(@"invocationOperation %@", [NSThread currentThread]);
}

@end

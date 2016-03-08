//
//  ViewController.m
//  NSThreadDemo
//
//  Created by ly on 16/3/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 总票 */
@property (nonatomic, assign) int tickes;
/** 锁对象 */
@property (nonatomic, strong) NSLock *myLock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testThread];
//    [self syncThread];
}
- (void)testThread {
    // 第一种 直接创建新线程并且开始运行线程
    [NSThread detachNewThreadSelector:@selector(myThread:) toTarget:self withObject:nil];
    
    // 第二种 先创建新线程，再运行操作，在运行操作前可以设置线程优先级等相关信息
    NSThread *myThread = [[NSThread alloc] initWithTarget:self selector:@selector(myThread:) object:nil];
    [myThread start];
    
    // 第三种 隐式创建
    [self performSelectorInBackground:@selector(myThread:) withObject:nil];
}
- (void)myThread:(NSThread *)sender {
    NSLog(@"%@", [NSThread currentThread]);
}

// 使用NSThread写一个经典的卖票的例子来讲线程同步
- (void)syncThread {
    // 初始化总票数
    self.tickes = 100;
    // 初始化锁对象
    self.myLock = [[NSLock alloc] init];
    // 创建两个线程，模拟网上售票和站台售票
    NSThread *onlineThread = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickes) object:nil];
    onlineThread.name = @"网上售票口";
    [onlineThread start];
    
    NSThread *stationThread = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickes) object:nil];
    stationThread.name = @"站点售票口";
    [stationThread start];
}
- (void)sellTickes {
    while (true) {
        // 加锁
        [self.myLock lock];
        // 模拟网络堵塞
        [NSThread sleepForTimeInterval:1];
        if (self.tickes > 0) {
            self.tickes -= 1;
            NSLog(@"当前售票口是:%@, 余票%d张。", [[NSThread currentThread] name], self.tickes);
        }else{
            NSLog(@"亲，你来晚了，票卖完了！");
            break;
        }
        // 解锁
        [self.myLock unlock];
        
    }
}

@end

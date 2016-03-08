//
//  GCDViewController.m
//  NSThreadDemo
//
//  Created by ly on 16/3/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/** 异步-全局并发 */
- (IBAction)async1 {
    // 获得全局并发队列（常用就是这个）
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"1 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"6 = %@", [NSThread currentThread]);
    });
    
    /*
     打印结果
     2016-03-08 13:26:13.109 NSThreadDemo[38192:1073138] 2 = <NSThread: 0x7fecf8da1cb0>{number = 3, name = (null)}
     2016-03-08 13:26:13.109 NSThreadDemo[38192:1073139] 3 = <NSThread: 0x7fecf8e30fe0>{number = 4, name = (null)}
     2016-03-08 13:26:13.109 NSThreadDemo[38192:1073140] 1 = <NSThread: 0x7fecf8f19840>{number = 2, name = (null)}
     2016-03-08 13:26:13.109 NSThreadDemo[38192:1073586] 5 = <NSThread: 0x7fecf8d04cd0>{number = 6, name = (null)}
     2016-03-08 13:26:13.109 NSThreadDemo[38192:1073585] 4 = <NSThread: 0x7fecf8f06c00>{number = 5, name = (null)}
     2016-03-08 13:26:13.110 NSThreadDemo[38192:1073138] 6 = <NSThread: 0x7fecf8da1cb0>{number = 3, name = (null)}
     */
}

/** 异步-串行 */
- (IBAction)async2 {
    // 自己创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("liyang", NULL);
    dispatch_async(queue, ^{
        NSLog(@"1 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5 = %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"6 = %@", [NSThread currentThread]);
    });
    
    /*
     打印结果
     2016-03-08 13:26:42.443 NSThreadDemo[38192:1078469] 1 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     2016-03-08 13:26:42.443 NSThreadDemo[38192:1078469] 2 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     2016-03-08 13:26:42.443 NSThreadDemo[38192:1078469] 3 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     2016-03-08 13:26:42.444 NSThreadDemo[38192:1078469] 4 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     2016-03-08 13:26:42.444 NSThreadDemo[38192:1078469] 5 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     2016-03-08 13:26:42.444 NSThreadDemo[38192:1078469] 6 = <NSThread: 0x7fecf8e1ef20>{number = 7, name = (null)}
     */
}

/** 同步-并发 */
- (IBAction)sync1 {
    // 获得全局并发队列（常用就是这个）
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{
        NSLog(@"1 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"5 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"6 = %@", [NSThread currentThread]);
    });
    /*
     打印结果
     2016-03-08 13:27:37.110 NSThreadDemo[38192:1072944] 1 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:27:37.110 NSThreadDemo[38192:1072944] 2 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:27:37.110 NSThreadDemo[38192:1072944] 3 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:27:37.110 NSThreadDemo[38192:1072944] 4 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:27:37.110 NSThreadDemo[38192:1072944] 5 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:27:37.111 NSThreadDemo[38192:1072944] 6 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     */
}

/** 同步-串行 */
- (IBAction)sync2 {
    // 自己创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("liyang", NULL);
    dispatch_sync(queue, ^{
        NSLog(@"1 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"5 = %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"6 = %@", [NSThread currentThread]);
    });
    /*
     打印结果
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 1 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 2 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 3 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 4 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 5 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     2016-03-08 13:28:06.597 NSThreadDemo[38192:1072944] 6 = <NSThread: 0x7fecf8e05160>{number = 1, name = main}
     */
}
@end

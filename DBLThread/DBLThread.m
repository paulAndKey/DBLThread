//
//  DBLThread.m
//  DBLThread
//
//  Created by dbl on 2020/3/1.
//  Copyright © 2020 dbl. All rights reserved.
//

#import "DBLThread.h"

@interface DBLThread()
@property (nonatomic,strong) NSThread *thread;
@property (nonatomic,assign) BOOL stoped;
@end

@implementation DBLThread

- (instancetype)init {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        self.thread = [[NSThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (!weakSelf.stoped && weakSelf) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

- (void)run {
    if (!self.thread) {
        return;
    }
    [self.thread start];
}

- (void)executeTask:(DBLThreadBlock)task {
    if (!self.thread || !task) {
        return;
    }
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.thread) {
        return;
    }
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    [self stop];
}
#pragma mark - private methods
- (void)__stop {
    self.stoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeTask:(DBLThreadBlock)task {
    task();
}

@end

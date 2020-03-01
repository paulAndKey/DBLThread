//
//  DBLThread.h
//  DBLThread
//
//  Created by dbl on 2020/3/1.
//  Copyright © 2020 dbl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DBLThreadBlock)(void);

@interface DBLThread : NSObject

/// 开启一个线程
- (void)run;

/// 要执行的任务
- (void)executeTask:(DBLThreadBlock)task;

/// 结束一个线程
- (void)stop;

@end

NS_ASSUME_NONNULL_END

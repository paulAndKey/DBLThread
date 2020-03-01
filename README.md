# DBLThread
子线程保持活跃

###用法简单，只需要导入头文件
```
#import "DBLThread.h"
@property (nonatomic,strong) DBLThread *thread;

self.thread = [[DBLThread alloc] init];
```

###开启
```
[self.thread run];
```

###结束
```
[self.thread stop];
```


//
//  NewBleTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "NewBleTask.h"
#import "CommandParser.h"

@implementation NewBleTask
{
    dispatch_block_t _timeoutBlock;
    dispatch_queue_t _queue;
}

- (instancetype)init{
    self = [super init];
    if (self) {

        self.timeout = NEVER;
        self.result = [NewBleResult getDefaultErrorResult];
        self.running = false;
    } 
    
    return self;
}

- (void)async{

    if (self.running == true) {
        return;
    }else{
        self.running = true;
    }
    if (self.timeout != NEVER) {
        [self startAsyncTimer];
    }
    if([self isAsyncPerform]) {
        [self perform];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self perform];
        });
    }
}

- (void)asyncTimeout {
    
    [[CommandParser sharedInstance] removeTask:self];
    self.running = false;
    [self stopPerform];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callback];
    });
}

- (void)finish{

    [self stopAsyncTimer];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callback];
    });
    self.running = false;
}

- (void)cancel{

    self.running = false;
    [self stopAsyncTimer];
    [self stopPerform];
}

- (void)startAsyncTimer{
    
    NSString *queueName = [NSString stringWithFormat:@"com.xzl.sdk.%@", NSStringFromClass([self class])];
    _queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
    _timeoutBlock = dispatch_block_create(0, ^{
        [self asyncTimeout];
    });
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, self.timeout * NSEC_PER_SEC);
    dispatch_after(overTime, _queue, _timeoutBlock);
}

- (void)stopAsyncTimer{
    
    
    if (_queue != NULL && _timeoutBlock != NULL) {
        //        DDLogDebug(@"%@ : %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        dispatch_suspend(_queue);
        dispatch_block_cancel(_timeoutBlock);
        dispatch_resume(_queue);
        _timeoutBlock = NULL;
        _queue = NULL;
    }
}

- (bool)isAsyncPerform{
    return true;
}

- (void)perform{
    NSAssert(false, @"this method should implement by sub class");
}

- (void)callback{
    NSAssert(false, @"this method should implement by sub class");
}

- (void)stopPerform{
    NSAssert(false, @"this method should implement by sub class");
}

- (void)ok:(NSString *)message{
    self.result.code = NBRC_Ok;
    self.result.message = message;
    [self finish];
}

- (void)error:(NSString *)message{
    self.result.code = NBRC_Error;
    self.result.message = message;
    [self finish];
}

@end

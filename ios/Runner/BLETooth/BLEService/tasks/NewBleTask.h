//
//  NewBleTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//
#import "FileLogger.h"
#import "LogManager.h"

#import <Foundation/Foundation.h>
#import "NewBleResult.h"
#define NEVER -1

@interface NewBleTask : NSObject

@property(nonatomic, strong) NewBleResult *result;
// 默认永不超时
@property(nonatomic, assign) int timeout;
@property(atomic, assign, getter=isRunning) bool running;


- (void)async;
- (void)cancel;
- (void)asyncTimeout;
- (instancetype)init;

//- (void)startAsyncTimer;
//- (void)stopAsyncTimer;
//- (void)asyncTimeout;
- (void)finish;     //任务执行完毕,将会引起callback被调用

- (bool)isAsyncPerform;
- (void)perform;    //子类实现,开始执行功能
- (void)stopPerform;    //子类实现,停止执行功能
- (void)callback;   //子类实现，回调给SDK外部

- (void)ok:(NSString *)message;
- (void)error:(NSString *)message;

@end


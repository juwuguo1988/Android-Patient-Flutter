//
//  CommandParser.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/20.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewBleTask.h"
#import "NewDeviceConstants.h"
#import "bleIOSSdk.h"

typedef void(^ErrorBlock)();
 
@interface CommandParser : NSObject

@property (nonatomic, weak) bleIOSSdk *iOSSdk;
//@property (nonatomic, copy) ErrorBlock BoxSuccessResponseBlock;

@property (nonatomic, strong, readonly) NSMutableDictionary *taskDic;

+ (CommandParser *)sharedInstance;

- (void)appendTask:(NewBleTask *)task taskId:(ActionID)taskId;

- (void)removeTaskId:(ActionID)taskId;

- (void)removeTask:(NewBleTask *)task;

- (void)handleNewBLEResultBusinessData:(NSData *)businessData storeId:(NSInteger)storeId;

//- (void)handleResult:(NSData *)result taskFlag:(NSString *)taskFlag;

- (void)sendFailTaskFlat:(char)taskFlag errorDes:(NSString *)errorDes;

@end


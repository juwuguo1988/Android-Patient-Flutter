//
//  NewBleResult.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "NewBleResult.h"

@implementation NewBleResult

- (instancetype)initWithCode:(NewBleReturnCode)code message:(NSString *)message{
    self = [super init];
    if (self) {
        _code = code;
        _message = message;
    }
    return self;
}

+(NewBleResult *)getDefaultErrorResult{
    NewBleResult *result = [[NewBleResult alloc] init];
    result.code = NBRC_Error;
    result.message = @"任务执行失败";
    
    return result;
}
+(NewBleResult *)getDefaultOkResult{
    NewBleResult *result = [[NewBleResult alloc] init];
    result.code = NBRC_Ok;
    result.message = @"任务执行成功";
    
    return result;
}

+(NewBleResult *)getDefaultDoNothing{
    NewBleResult *result = [[NewBleResult alloc] init];
    result.code = NBRC_DoNothing;
    result.message = @"无操作";
    
    return result;
}

@end

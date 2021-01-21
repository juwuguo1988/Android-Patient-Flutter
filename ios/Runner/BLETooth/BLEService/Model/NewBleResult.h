//
//  NewBleResult.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZLNewPillBoxMessage.h"

typedef NS_ENUM (NSInteger, NewBleReturnCode)
{
    NBRC_Ok = 0,
    NBRC_Error,
    NBRC_DoNothing,
};

@interface NewBleResult : NSObject

@property(nonatomic, assign) NewBleReturnCode code;
@property(nonatomic, copy) NSString *message;
/**
 会根据task变化，resopnMessage所属的类也会变化
 */
@property(nonatomic, strong) XZLNewPillBoxResponSimpleMessage *resopnMessage;

- (instancetype)initWithCode:(NewBleReturnCode)code message:(NSString *)message;

+(NewBleResult *)getDefaultErrorResult;
+(NewBleResult *)getDefaultOkResult;
+(NewBleResult *)getDefaultDoNothing;

@end


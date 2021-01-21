//
//  BaseDeviceTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"

@implementation BaseDeviceTask

- (instancetype)initWithBleIOSSdk:(bleIOSSdk *)IOSSdk {
    
    self = [super init];
    if (self) {
        _iOSSdk = IOSSdk;
    }
    return self;
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BaseDeviceTask:stopPerform");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BaseDeviceTask:callback");
}

@end

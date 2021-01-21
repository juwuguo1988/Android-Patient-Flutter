//
//  GetDeviceTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "GetDeviceTask.h"
#import "ConnectService.h"

@implementation GetDeviceTask

- (instancetype)initWithDeviceName:(NSString *)deviceName type:(DeviceType)type {
    
    self = [super init];
    if (self) {
        _deviceName = deviceName;
        _deviceType = type;
    }
    return self;
} 
 
- (void)perform {
    
    DDLogDebug(@"zhousuhua --- GetDeviceTask--perform...");
    [self getDevice];
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- GetDeviceTask--stopPerform...");
    [[ConnectService sharedInstance] stopScan];
}

- (void)getDevice {
    
    _device = [[ConnectService sharedInstance] getDeviceByName:_deviceName];
    
    if (_device == nil) {
        DDLogDebug(@"zhousuhua --- GetDeviceTask--START...");
        [[ConnectService sharedInstance] scanDevice:_deviceName ofType:_deviceType completeHandler:^(__kindof Device * _Nullable device) {
            self->_device = device;
            if (self->_device != nil) {
              //  DDLogError(@"found device %@", _device);
                self.result.code = NBRC_Ok;
            } else {
              //  DDLogError(@"not found device");
            }

            [self finish];
        }];
    }else{
         DDLogDebug(@"zhousuhua --- GetDeviceTask--finish...");
        self.result.code = NBRC_Ok;
        [self finish];
    }
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- GetDeviceTask--callback...");
    _completeHandler(self.result, self.device);
}

@end

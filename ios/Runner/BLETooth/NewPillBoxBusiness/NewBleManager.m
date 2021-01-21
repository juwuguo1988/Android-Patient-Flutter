//
//  NewBleManager.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "NewBleManager.h"
#import "GetDeviceTask.h"
#import "ConnectService.h"

@implementation NewBleManager

+ (void)initManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //初始化蓝牙中心
        [ConnectService sharedInstance];
    });
}

+ (void)destroy {
    
    return [[ConnectService sharedInstance] destroy];
}

+ (NewBleTask *)getDevice:(NSString *)deviceName ofType:(DeviceType)type completeHandler:(GetDeviceHandler)handler {
    
    GetDeviceTask *task = [[GetDeviceTask alloc] initWithDeviceName:deviceName type:type];
    task.completeHandler = handler;
    task.deviceType = type;
    task.deviceName = deviceName;
    
    return task;
}

+ (void)removeAllDevices {
    
   [[ConnectService sharedInstance] disConncectAllDevice];
}


+ (void)removeDevice:(NSString *)deviceMac completeHandler:(SimpleBlock)handler {
    
    Device *device = [[ConnectService sharedInstance] getDeviceByName:deviceMac];
   // Device *device = [[ConnectService sharedInstance] getDeviceByMac:@"MBox-0A:3F:9C"];
    // _device = [[ConnectService sharedInstance] getDfthDeviceByMac:_deviceMac];
    if (device) {
        
        [device destory];
    }
}


@end

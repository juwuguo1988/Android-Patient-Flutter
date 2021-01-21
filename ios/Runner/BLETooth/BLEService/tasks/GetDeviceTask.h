//
//  GetDeviceTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "NewBleTask.h"
#import "Device.h"
#import "NewDeviceConstants.h"
#import "NewBlockBlocks.h"

@interface GetDeviceTask : NewBleTask

@property(nonatomic, copy) NSString *deviceName;
@property(nonatomic, assign) DeviceType deviceType;
@property(nonatomic, strong) __kindof Device *device;
@property(nonatomic, strong) GetDeviceHandler completeHandler;

- (instancetype)initWithDeviceName:(NSString *)deviceName type:(DeviceType)type;

@end



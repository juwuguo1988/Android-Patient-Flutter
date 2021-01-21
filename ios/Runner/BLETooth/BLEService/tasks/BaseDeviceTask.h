//
//  BaseDeviceTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "NewBleTask.h"
#import "Device.h"
#import "bleIOSSdk.h"
#import "FileLogger.h"
#import "LogManager.h"

@class BabyBluetooth;

@interface BaseDeviceTask : NewBleTask

@property (nonatomic, weak)  bleIOSSdk *iOSSdk;
@property (nonatomic, weak)  Device *device;

- (instancetype)initWithBleIOSSdk:(bleIOSSdk *)IOSSdk;


@end


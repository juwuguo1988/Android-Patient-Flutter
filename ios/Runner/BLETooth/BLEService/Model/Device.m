//
//  Device.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "Device.h"
#import "ConnectService.h"

@interface Device () {
    
    CBPeripheral *_peripheral;
}

@end

@implementation Device

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    
    self = [super init];
    if (self) {
        
        _name = peripheral.name;
        _type = DT_Unknown;
        _version = @"";
        _battery = 100;
        _commandSender = [[CommandSender alloc] init];
        _peripheral = peripheral;
    }
    return self;
}

- (void)destory {
     
    NewBleTask *task = [self getDisconnectTaskWithCompleteHandler:^(NewBleResult * _Nonnull result) {
       
        self.userId = nil;
        [[ConnectService sharedInstance].allDevices removeObjectForKey:self.name];
    }];
    task.timeout = 30;
    [task async];
}

- (CBPeripheral *)getPeripheral {
    
    return _peripheral;
}

- (bool)isConnected {
    
    return _peripheral.state == CBPeripheralStateConnected;
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@" name:%@, type:%lld", _name, (int64_t)_type];
}

 

@end

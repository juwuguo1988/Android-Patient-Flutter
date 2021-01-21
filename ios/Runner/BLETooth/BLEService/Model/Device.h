//
//  Device.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewDeviceConstants.h"
#import "CommandSender.h"
#import "CommandParser.h"
#import "DeviceInterface.h"
#import "ThirdDeviceInterface.h"

@interface Device : NSObject  <DeviceInterface,ThirdDeviceInterface>

@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) DeviceType type;
@property(nonatomic, copy) NSString *version;
@property(nonatomic, assign) float battery;

@property(nonatomic, assign, getter=isConnected, readonly) bool connected;
 
/** 指令发送类 */
@property (nonatomic, strong) BleDataModel *boxDeviceModel;
/** 指令发送类 */
@property (nonatomic, strong) CommandSender *commandSender;


- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;
- (CBPeripheral *)getPeripheral;


@end
 

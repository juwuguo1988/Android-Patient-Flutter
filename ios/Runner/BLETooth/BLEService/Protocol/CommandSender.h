//
//  CommandSender.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "NewDeviceConstants.h"
//#import "XZLPillBoxMessage.h"
#import "CommandSenderInterface.h"
#import "CommandParser.h"

@interface CommandSender : NSObject <CommandSenderInterface>

//@property(nonatomic, weak) CBPeripheral *peripheral;
//@property(nonatomic, strong) CBCharacteristic *writeCharacter;



@end


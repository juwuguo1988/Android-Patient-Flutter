//
//  BT_GetDeviceBattery.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/5/22.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_GetDeviceBattery.h"

@implementation BT_GetDeviceBattery

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_GetDeviceBattery--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_GetDeviceBattery--START...");
        [self.device.commandSender getDeviceBatteryCommand:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_GetDeviceBattery--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_GetDeviceBattery--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_GetDeviceBattery--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

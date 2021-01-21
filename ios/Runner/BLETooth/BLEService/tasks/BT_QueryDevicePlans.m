//
//  BT_QueryDevicePlans.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_QueryDevicePlans.h"

@implementation BT_QueryDevicePlans


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_QueryDevicePlans--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_QueryDevicePlans--START...");
        
        [self.device.commandSender queryDevicePlans:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_QueryDevicePlans--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_QueryDevicePlans--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_QueryDevicePlans--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

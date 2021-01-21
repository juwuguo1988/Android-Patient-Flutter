//
//  BT_BindDevice.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/19.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_BindDevice.h"


@implementation BT_BindDevice


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_BindDevice--perform...");
    if ([self.device isConnected]) {
        DDLogDebug(@"zhousuhua --- BT_BindDevice--START CONNECT...");
        [self.device.commandSender bindDevice:self boxDeviceModel:_boxDeviceModel];
       
    } else {
        DDLogDebug(@"zhousuhua --- BT_BindDevice--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_BindDevice--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_BindDevice--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

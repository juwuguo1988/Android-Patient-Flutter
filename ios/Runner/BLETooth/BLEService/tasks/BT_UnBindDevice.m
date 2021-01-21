//
//  BT_UnBindDevice.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/21.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_UnBindDevice.h"

@implementation BT_UnBindDevice


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_BindDevice--perform...");
    if ([self.device isConnected]) {
        DDLogDebug(@"zhousuhua --- BT_BindDevice--START CONNECT...");
        [self.device.commandSender disBindDevice:self boxId:_boxId];
        
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

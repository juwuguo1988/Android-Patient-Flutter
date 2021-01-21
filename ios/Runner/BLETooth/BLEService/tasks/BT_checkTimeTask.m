//
//  BT_checkTimeTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_checkTimeTask.h"

@implementation BT_checkTimeTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_checkTimeTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_checkTimeTask--START...");
        [self.device.commandSender checkTime:self time:_ts];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_checkTimeTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_checkTimeTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_checkTimeTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

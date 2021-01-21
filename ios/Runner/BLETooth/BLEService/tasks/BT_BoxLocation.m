//
//  BT_BoxLocation.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_BoxLocation.h"

@implementation BT_BoxLocation

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxLocation--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_BoxLocation--START...");
        [self.device.commandSender boxLoaction:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_BoxLocation--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxLocation--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_BoxLocation--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

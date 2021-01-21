//
//  BT_BoxState.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_BoxState.h"

@implementation BT_BoxState

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxState--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_BoxState--START...");
        [self.device.commandSender getBoxStateCommand:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_BoxState--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxState--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_BoxState--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

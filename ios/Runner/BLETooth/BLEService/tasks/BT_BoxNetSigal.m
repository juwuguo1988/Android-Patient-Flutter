//
//  BT_BoxNetSigal.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_BoxNetSigal.h"

@implementation BT_BoxNetSigal

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxNetSigal--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_BoxNetSigal--START...");
        [self.device.commandSender boxNetSigal:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_BoxNetSigal--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_BoxNetSigal--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_BoxNetSigal--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}


@end

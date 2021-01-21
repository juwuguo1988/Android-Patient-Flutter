//
//  BT_ShakeBoxTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_ShakeBoxTask.h"

@implementation BT_ShakeBoxTask


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_ShakeBoxTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_ShakeBoxTask--START...");
        [self.device.commandSender shake:self shakeStyle:_shakeStyle totalTime:_totalTime model:_model];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_ShakeBoxTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_ShakeBoxTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_ShakeBoxTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

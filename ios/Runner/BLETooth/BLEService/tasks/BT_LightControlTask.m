//
//  BT_LightControlTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/25.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_LightControlTask.h"

@implementation BT_LightControlTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_LightControlTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_LightControlTask--START...");
        [self.device.commandSender lightCommand:self lightType:_lightType flashStyle:_flashStyle totalTime:_totalTime];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_LightControlTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_LightControlTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_LightControlTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

//
//  BT_DeletePlanTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/24.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_DeletePlanTask.h"

@implementation BT_DeletePlanTask


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_DeletePlanTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_DeletePlanTask--START...");
        [self.device.commandSender deletePlanToDevice:self planInfoArr:_takePlanIds];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_DeletePlanTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_DeletePlanTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_DeletePlanTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

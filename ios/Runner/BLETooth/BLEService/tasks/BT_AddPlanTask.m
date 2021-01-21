//
//  BT_AddPlanTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/24.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_AddPlanTask.h"

@implementation BT_AddPlanTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_AddPlanTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_AddPlanTask--START...");
        [self.device.commandSender addPlanToDevice:self planInfoArr:_takePlanIds];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_AddPlanTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_AddPlanTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_AddPlanTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}


@end

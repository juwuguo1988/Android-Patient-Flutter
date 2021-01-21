//
//  BT_editPlanTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/27.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_EditPlanTask.h"

@implementation BT_EditPlanTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_EditPlanTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_EditPlanTask--START...");
        [self.device.commandSender editPlanToDevice:self oldPlanArr:_oldPlanArr newPlans:_nowPlanArr oldPos:_oldPos];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_EditPlanTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_EditPlanTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_EditPlanTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

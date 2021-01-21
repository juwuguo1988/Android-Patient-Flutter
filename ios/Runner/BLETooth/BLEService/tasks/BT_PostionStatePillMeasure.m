//
//  BT_PostionStatePillMeasure.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_PostionStatePillMeasure.h"

@implementation BT_PostionStatePillMeasure

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_PostionStatePillMeasure--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_PostionStatePillMeasure--START...");
        [self.device.commandSender getPostionStateCommand:self postions:_postions];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_PostionStatePillMeasure--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_PostionStatePillMeasure--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_PostionStatePillMeasure--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

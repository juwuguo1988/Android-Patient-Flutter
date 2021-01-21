//
//  BT_GetCellWeight.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/5/22.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_GetCellWeight.h"

@implementation BT_GetCellWeight

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_GetCellWeight--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_GetCellWeight--START...");
        [self.device.commandSender getCellWeightCommand:self postions:_postions];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_GetCellWeight--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_GetCellWeight--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_GetCellWeight--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

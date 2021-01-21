//
//  BT_FillMedicTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/25.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_FillMedicTask.h"


@implementation BT_FillMedicTask


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_FillMedicTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_FillMedicTask--START...");
        
        [self.device.commandSender fillMedicineCommand:self postions:_postions];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_FillMedicTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_FillMedicTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_FillMedicTask--callback...");
    if (self.completeHandler != NULL) {
        
        self.completeHandler(self.result);
    }
}

@end

//
//  BT_MedicationReminder.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_MedicationReminder.h"

@implementation BT_MedicationReminder

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_MedicationReminder--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_MedicationReminder--START...");
        
        [self.device.commandSender medicationReminder:self delayPlans:_delayPlans];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_MedicationReminder--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_MedicationReminder--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_MedicationReminder--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

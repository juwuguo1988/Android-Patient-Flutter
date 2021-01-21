//
//  BT_SoundControl.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_SoundControl.h"

@implementation BT_SoundControl

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_SoundControl--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_SoundControl--START...");
        [self.device.commandSender sound:self sountType:_sountType model:_model volume:_volume];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_SoundControl--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_SoundControl--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_SoundControl--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

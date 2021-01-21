//
//  BT_WillSpeech.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/1.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_WillSpeech.h"

@implementation BT_WillSpeech


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_WillSpeech--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_WillSpeech--START...");
        [self.device.commandSender WillSpeech:self cell:_cell len:_len];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_WillSpeech--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_WillSpeech--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_WillSpeech--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

//
//  BT_WillFontText.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/4.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_WillFontText.h"

@implementation BT_WillFontText


- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_WillSpeech--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_WillSpeech--START...");
        
        [self.device.commandSender WillFontSend:self cell:_cell len:_len];
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

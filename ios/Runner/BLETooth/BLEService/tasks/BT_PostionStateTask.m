//
//  BT_PostionStateTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/25.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_PostionStateTask.h"

@implementation BT_PostionStateTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_PostionStateTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_PostionStateTask--START...");
         [self.device.commandSender notifyPostionStateCommand:self];
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_PostionStateTask--finish...");
        [self finish];
    }
}

- (void)asyncTimeout {
    
    self.running = false;
    [self stopPerform];
    _pos = -1;
    [self.device.commandSender removeNotifyPostionState];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callback];
    });
}

- (void)finish{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callback];
    });
}

- (void)stopPerform {
     
    DDLogDebug(@"zhousuhua --- BT_PostionStateTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_PostionStateTask--callback...");
    if (self.result.code == NBRC_Error) {
        _pos = -1;
    }
    if (self.completeHandler != NULL) {
        self.completeHandler(_pos,_coverState);
    }
}

@end

//
//  BT_VoiceSendTask.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/6/29.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BT_VoiceSendTask.h"

@implementation BT_VoiceSendTask

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--perform...");
    if ([self.device isConnected]) {
        
        DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--START...");
        if (_dataType == VoiceType) {
            
            [self.device.commandSender voiceDataSend:self data:_data postion:_positionNo];
        } else if (_dataType == FontTextType)  {
            
            [self.device.commandSender latticeDataSend:self data:_data postion:_positionNo];
        } else if (_dataType == PersonVoiceType)  {
            
            [self.device.commandSender personalVoice:self data:_data];
        } else if (_dataType == PersonTextType)  {
            
            [self.device.commandSender personalText:self data:_data];
        } else {
            
            DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--未指定发送数据类型...");
            [self finish];
            DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--finish...");
        }
        
    } else {
        
        DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--stopPerform...");
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_VoiceSendTask--callback...");
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

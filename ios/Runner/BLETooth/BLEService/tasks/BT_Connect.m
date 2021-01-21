//
//  BT_Connect.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_Connect.h"

@implementation BT_Connect

- (void)perform {
    
    DDLogDebug(@"zhousuhua --- BT_Connect--perform...");
    
    if (![self.device isConnected]) {
        DDLogDebug(@"zhousuhua --- BT_Connect--START CONNECT...");
        [self.iOSSdk connectDevice:[self.device getPeripheral]];
    } else {
         DDLogDebug(@"zhousuhua --- BT_Connect--finish...");
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_Connect--stopPerform...");
    [[self.iOSSdk getBluetoothPtr] cancelPeripheralConnection:[self.device getPeripheral]];
   // [self.babyBle cancelPeripheralConnection:[self.device getPeripheral]];
}

- (void)callback {
    
    DDLogDebug(@"zhousuhua --- BT_Connect--callback...");
    
    if (self.device.getPeripheral.state == CBPeripheralStateConnected) {
        
        self.result.code = NBRC_Ok;
    }
    if (self.completeHandler != NULL) {
        self.completeHandler(self.result);
    }
}

@end

//
//  BT_Disconnect.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BT_Disconnect.h"

@implementation BT_Disconnect

- (void)perform {
    
    if (self.device.isConnected) {
        
        [[self.iOSSdk getBluetoothPtr] cancelPeripheralConnection:[self.device getPeripheral]];
      //  [self.babyBle cancelPeripheralConnection:[self.device getPeripheral]];
       // [self.manager cancelPeripheralConnection:[self.device getPeripheral]];
    } else {
        
        [self finish];
    }
}

- (void)stopPerform {
    
    DDLogDebug(@"zhousuhua --- BT_Disconnect:stopPerform");
}

- (void)callback {
    
    if (self.result.code == NBRC_Ok || !self.device.isConnected) {
        
        self.result.code = NBRC_Ok;
    }
    
    self.completeHandler(self.result);
}

@end

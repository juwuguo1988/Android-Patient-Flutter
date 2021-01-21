//
//  ConnectService.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "ConnectService.h"
#import "ThirdPillBoxDevice.h"
#import "CommandParser.h"
//#import "XZLBleDataHandle.h"
//#import "XZLAllPillBoxBusiness.h"

@implementation ConnectService {
    dispatch_queue_t _queue;
//   XZLBleDataHandle *_dataHandle;
}

+ (ConnectService *)sharedInstance {
    static ConnectService *_service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[ConnectService alloc] init];
    });
    
    return _service;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
//        _dataHandle = [[XZLBleDataHandle alloc] init];
        self.allDevices = [[NSMutableDictionary alloc] init];
        self.bleSdk = [[bleIOSSdk alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"GBK16crx" ofType:@"bin"];
        [self.bleSdk initSdk:path];
        [self babyDelegate];
        [self.bleSdk setDelegate:self];
        [CommandParser sharedInstance].iOSSdk = self.bleSdk;
    }
    return self;
}

- (void)destroy {
    
//    [self disConncectAllDevice];
    [self.bleSdk unInitSdk];
}

- (void)disConncectAllDevice {
    
    for (Device *device in [_allDevices allValues]) {
        [device destory];
    }
}

- (void)scanDevice:(nullable NSString *)deviceName ofType:(DeviceType)deviceType completeHandler:(ScanDeviceBlock)handler {
    
     BabyBluetooth *baby = [self.bleSdk getBluetoothPtr];
    
    if (baby.centralManager.state == CBManagerStatePoweredOn) {
        
        if(Nil != baby) {
            
            baby.scanForPeripherals().begin();
        }
        _scanDeviceName = deviceName;
        _deviceTypeScan = deviceType;
        _scanComplete = handler;
    }
}

- (void)stopScan {
    
    BabyBluetooth *baby = [self.bleSdk getBluetoothPtr];
    [baby cancelScan];
    _deviceTypeScan = DT_Unknown;
}

- (BT_Connect *)getConnectTaskForDevice:(Device *)device {
    
    _connectTask = [[BT_Connect alloc] initWithBleIOSSdk:self.bleSdk];
    _connectTask.device = device;
    return _connectTask;
}

- (BT_Disconnect *)getDisconnectTaskForDevice:(Device *)device {
    
    _disconnectTask = [[BT_Disconnect alloc] initWithBleIOSSdk:self.bleSdk];
//    _disconnectTask = [[BT_Disconnect alloc] initWithCentralManager:_manager];
    _disconnectTask.device = device;
    return _disconnectTask;
}

- (Device *)getDeviceByName:(NSString *)deviceName {
//- (Device *)getDeviceByMac:(NSString *)deviceMac {
    
//    NSString *spiltMac = [[deviceMac componentsSeparatedByString:@":"] componentsJoinedByString:@""];
    return [_allDevices objectForKey:deviceName];
}

- (Device *)getDeviceByPeripheral:(CBPeripheral *)peripheral {
    
    NSArray *deviceArray = [_allDevices allValues];
    for (Device *device in deviceArray) {
        if ([[device getPeripheral] isEqual: peripheral]) {
            return device;
        }
    }
    
    return nil;
}


#pragma mark ------蓝牙中心协议------

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate {
    
    __weak typeof(self) weakSelf = self;
    BabyBluetooth *baby = [self.bleSdk getBluetoothPtr];
    if(Nil != baby) {
        [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
            
            switch (central.state) {
                case CBCentralManagerStateUnknown:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStateUnknown");
                    break;
                case CBCentralManagerStateResetting:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStateResetting");
                    break;
                case CBCentralManagerStateUnsupported:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStateUnsupported");
                    break;
                case CBCentralManagerStateUnauthorized:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStateUnauthorized");
                    break;
                case CBCentralManagerStatePoweredOff:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStatePoweredOff");
                    break;
                case CBCentralManagerStatePoweredOn:
                    DDLogDebug(@"zhousuhua --- CBCentralManagerStatePoweredOn");
                    break;
                default:
                    break;
            }
        }];
        
        //设置扫描到设备的委托
        [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
            
            DDLogDebug(@"扫描到设备:%@",peripheral.name);
            if ([peripheral.name hasPrefix:@"MBox"]) {
                
              DDLogDebug(@"扫描到设备:%@",peripheral.name);
            }
            [weakSelf foundDevice:peripheral name:peripheral.name];
        }];
        
        // 连接设备失败
        [baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
            
            [weakSelf connectTaskFinish];
        }];
                
        // 断开Peripherals的连接的block
        [baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
            
            if (peripheral == [self->_disconnectTask.device getPeripheral]) {
                self->_disconnectTask.result.code = NBRC_Ok;
                [self->_disconnectTask finish];
                self->_disconnectTask = nil;
            } else if (peripheral == [self->_connectTask.device getPeripheral] && [self->_connectTask isRunning]) {
                //        [NSThread sleepForTimeInterval:0.5];
                DDLogDebug(@"连接中重连...");
                [weakSelf.bleSdk connectDevice:peripheral];
            }
        }];
    }
}

- (void)onConnec:(int)retCode withDev:(CBPeripheral *)currPeripheral {
//-(void)onConnec: (int) retCode {

    DDLogDebug(@"zhousuhua -onConnec:%d--- currPeripheral:%@",retCode,currPeripheral);
//    [XZLPillBoxDefuaultBusiness thirdDeviceSendDatas:NO];
    if ( ERR_SUCCESS == retCode ) {
        
      //  [self connectTaskOk];
        DDLogDebug(@"zhousuhua ---- 设备--连接成功");
         
    } else if ( ERR_FAILED == retCode ) {
        
        DDLogDebug(@"zhousuhua ---- 设备--连接失败");
//        [XZLPillBoxDefuaultBusiness thirdDeviceSendDatas:NO];
//        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdUnKnow errorDes:@"蓝牙连接断开"];

        if (currPeripheral == [self->_disconnectTask.device getPeripheral]) {
            self->_disconnectTask.result.code = NBRC_Ok;
            [self->_disconnectTask finish];
            self->_disconnectTask = nil;
        } else if (currPeripheral == [self->_connectTask.device getPeripheral] && [self->_connectTask isRunning]) {
            DDLogDebug(@"连接中重连...");
          //  [self.bleSdk connectDevice:currPeripheral];
        } else {
            
            DDLogDebug(@"connectTaskError...");
         //   [self connectTaskError];
        }
        
    } else if( ERR_CAN_SENDDATA == retCode ) {

        [self connectTaskOk];
        DDLogDebug(@"zhousuhua ---- ERR_CAN_SENDDATA");
    }
} 

- (void)onSendDataResult:(int)retCode with:(DataInfoOC *)dataInfoOC withDev:(CBPeripheral *)currPeripheral {
    
    DDLogDebug(@"onSendDataResult retCode:%d dataLen:%d taskId:%d storeId:%d", retCode, [dataInfoOC dataLen], [dataInfoOC taskId], [dataInfoOC storeId]);
    
    if (retCode != ERR_SUCCESS) {
        
        [[CommandParser sharedInstance] sendFailTaskFlat:[dataInfoOC taskId] errorDes:@"数据发送失败"];
    } else {
        
//        if ([dataInfoOC storeId] == SoundAction || [dataInfoOC storeId] == ShakeAction) {
//
//            [[CommandParser sharedInstance] handleNewBLEResultBusinessData:nil storeId:[dataInfoOC storeId]];
//        }
    }
}

-(void)onSendProgress:(int)allPkgCnt with:(int)sentPkgCnt withDev:(CBPeripheral *)currPeripheral {
    
    DDLogDebug(@"onSendProgress allPkgCnt:%d sentPkgCnt:%d currPeripheral:%@",allPkgCnt, sentPkgCnt, currPeripheral);
    
//    [XZLPillBoxDefuaultBusiness thirdDeviceVoiceLatticeProcess:(sentPkgCnt/(allPkgCnt*1.0))];
//    if (allPkgCnt != sentPkgCnt) {
//
//        [XZLPillBoxDefuaultBusiness thirdDeviceSendDatas:YES];
//    } else {
//
//        [XZLPillBoxDefuaultBusiness thirdDeviceSendDatas:NO];
//    }
}

- (void)onRecvBleData:(NSData *)businessData with:(DataInfoOC *)dataInfoOC withDev:(CBPeripheral *)currPeripheral {

    NSString *businessStr = [[NSString alloc] initWithData:businessData encoding:NSUTF8StringEncoding];
    DDLogDebug(@"onRecvBleData str:%@", businessStr);
    
    [[CommandParser sharedInstance] handleNewBLEResultBusinessData:businessData storeId:[dataInfoOC storeId]];
}

#pragma mark ------私有方法------

- (NSString *)getMacAddress:(NSDictionary <NSString *,id>*)advertisementData {
    
    if ([advertisementData objectForKey:@"kCBAdvDataManufacturerData"]) {
        
        NSData *manufacturerData = [[NSData alloc] initWithData:advertisementData[@"kCBAdvDataManufacturerData"]];
        if (manufacturerData.length >= 16) {
            
            NSData *macData = [manufacturerData subdataWithRange:NSMakeRange(4, 12)];
            NSMutableString *mac = [NSMutableString string];
            for (int i = 0; i < macData.length; i++) {
                
                NSData *ascData = [macData subdataWithRange:NSMakeRange(i, 1)];
                [mac appendString:[[NSString alloc] initWithData:ascData encoding:NSASCIIStringEncoding]];
            }
            return mac;
        }
    } else if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        
        NSString *macName = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
        return macName;
    }
    return @"";
}

- (void)foundDevice:(CBPeripheral *)peripheral name:(NSString *)deviceName {
    
    if (_scanDeviceName.length > 0) {

        if ([self fetchDeviceModelWithName:deviceName]) {

            Device *device = [self createDeviceByperipheral:peripheral];
            [_allDevices setObject:device forKey:deviceName];
            [self stopScan];
            if (_scanComplete) {
            _scanComplete(device);
            }
        }
    } else {
    
        [self stopScan];
        if (_scanComplete) {
            _scanComplete(nil);
        }
    }
}

- (DeviceType)getDeviceTypeByName:(NSString *)name {
    
    if ([name hasPrefix:@"MBox"]) {
        return DT_ThreePillBox;
    } else {
        return DT_Unknown;
    }
}

- (BOOL)fetchDeviceModelWithName:(NSString *)deviceName {

    return [_scanDeviceName isEqualToString:deviceName];
}

- (Device*)createDeviceByperipheral:(CBPeripheral *)peripheral {
    
   if (_deviceTypeScan == DT_ThreePillBox) {
        
        ThirdPillBoxDevice *thirdDevice = [[ThirdPillBoxDevice alloc] initWithPeripheral:peripheral];
        ((ThirdCommandSender *)(thirdDevice.commandSender)).iOSSdk = self.bleSdk;

        return thirdDevice;
    } else {
        
        return [[Device alloc] initWithPeripheral:peripheral];
    }
}

- (void)connectTaskOk {
    
    if (_connectTask) {
        _connectTask.result.code = NBRC_Ok;
        [self connectTaskFinish];
    }
}

- (void)connectTaskError {
    
    if (_connectTask) {
        _connectTask.result.code = NBRC_Error;
        [self connectTaskFinish];
    }
}

- (void)connectTaskFinish {
    
    [_connectTask finish];
}

@end

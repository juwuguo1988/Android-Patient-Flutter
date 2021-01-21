//
//  ConnectService.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "NewDeviceConstants.h"
#import "Device.h"
#import "BT_Connect.h"
#import "BT_Disconnect.h"
#import "bleIOSSdk.h"

//NS_ASSUME_NONNULL_BEGIN
typedef void(^ScanDeviceBlock)(Device *device);

@interface ConnectService : NSObject <bleIOSSdkDelegate>
 
@property (strong, nonatomic)  bleIOSSdk *bleSdk;
@property (nonatomic, assign) DeviceType deviceTypeScan;
@property (nonatomic, copy) NSString *scanDeviceName;
@property (nonatomic,strong) NSMutableDictionary *allDevices;
@property (nonatomic, strong) BT_Connect *connectTask;
@property (nonatomic, strong) BT_Disconnect *disconnectTask;
@property (nonatomic, strong) ScanDeviceBlock scanComplete;

+ (ConnectService *)sharedInstance;
- (void)destroy;
- (void)disConncectAllDevice;

- (void)scanDevice:(NSString *)deviceName ofType:(DeviceType)deviceType completeHandler:(ScanDeviceBlock)handler;
- (void)stopScan;

- (BT_Connect *)getConnectTaskForDevice:(Device *)device;
- (BT_Disconnect *)getDisconnectTaskForDevice:(Device *)device;

//- (Device *)getDeviceByMac:(NSString *)deviceMac;

- (Device *)getDeviceByName:(NSString *)deviceName;

@end
//NS_ASSUME_NONNULL_END

//
//  bleIOSSdk.h
//  bleIOSSdk
//
//  Created by 董海伟 on 2019/2/6.
//  Copyright © 2019 董海伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabyBluetooth.h"
#import "DataInfoOC.h"

enum {
    ERR_SUCCESS = 0,
    ERR_FAILED,
    ERR_CAN_SENDDATA,
};

@protocol bleIOSSdkDelegate <NSObject>
-(void)onConnec:(int)retCode withDev:(CBPeripheral *)currPeripheral;
-(void)onSendDataResult:(int)retCode with:(DataInfoOC*)dataInfoOC withDev:(CBPeripheral *)currPeripheral;
-(void)onSendProgress:(int)allPkgCnt with:(int)sentPkgCnt withDev:(CBPeripheral *)currPeripheral;
-(void)onRecvBleData:(NSData*) businessData with:(DataInfoOC*)dataInfoOC withDev:(CBPeripheral *)currPeripheral;
@end

@interface bleIOSSdk : NSObject
@property(nonatomic, assign) id<bleIOSSdkDelegate> delegate;

- (BabyBluetooth*) getBluetoothPtr;
- (void) initSdk: (NSString *) strHzkFileName;
- (void) unInitSdk;

/**
 *  connectDevice返回int，返回0启动连接成功等待回调
 *    1.已连接
 *    2.sdk未初始化
 *    3.设备标识currPeripheral为空
 *    4.其他设备连接中，必须先断开其他设备连接
 **/
- (int)  connectDevice: (CBPeripheral *)currPeripheral;

/**
 *  返回: 0.成功，1 已断开连接，其他失败
 **/
- (int)  sendData: (NSData *) businessData withTid: (char) tid withSid: (char) sid;

- (void) stopSendData;

/**
 *  返回: 0.未连接，1.已连接设备，2.sdk未初始化
 **/
- (int) isDevConnected;

/**
 *  返回 0.执行成功
 *      1.失败：传入地址为空
 *      2.sdk未初始化
 *      3.失败：传入地址尚未连接
 **/
- (int) disConnectDevice: (CBPeripheral *)currPeripheral;


+ (NSData *) converHexStrToData: (NSString *) str;

@end

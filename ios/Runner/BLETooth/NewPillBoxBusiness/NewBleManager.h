//
//  NewBleManager.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewDeviceConstants.h"
#import "NewBleTask.h"
#import "NewBlockBlocks.h"
#import "Device.h"

@interface NewBleManager : NSObject

/**
 * 程序启动后需要立即调用此接口初始化，建议放在AppDelegate中调用
 */
+ (void)initManager;

/**
 * 销毁 NewBleManager
 */
+ (void)destroy;
/**
 *    获取设备
 *
 * @param deviceName 指定需要连接的设备的name
 * @param type 用户ID
 * @param handler 任务执行完成的回调
 *
 * @return DfthTask
 */
+ (NewBleTask *)getDevice:(NSString *)deviceName ofType:(DeviceType)type completeHandler:(GetDeviceHandler)handler;

+ (void)removeAllDevices;

+ (void)removeDevice:(NSString *)deviceMac completeHandler:(SimpleBlock)handler;

@end


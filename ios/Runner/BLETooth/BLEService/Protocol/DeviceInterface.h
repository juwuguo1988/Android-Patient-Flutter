//
//  DeviceInterface.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewBleTask.h"
#import "NewBlockBlocks.h"

@class BaseDeviceTask;
@class BleDataModel;

@protocol DeviceInterface <NSObject>

@optional

/**
 释放设备
 */
- (void)destory;

/**
 获取连接设备的任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getConnectTaskWithCompleteHandler:(SimpleBlock)handler;

/**
 获取断开连接的任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getDisconnectTaskWithCompleteHandler:(SimpleBlock)handler;

/**
 获取药盒电源和电量
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getDeviceBatteryTaskWithCompleteHandler:(SimpleBlock)handler;

/**
 获取绑定设备任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
//- (NewBleTask *)getBindDeviceTaskWithCompleteHandler:(SimpleBlock)handler;
- (NewBleTask *)getBindDeviceTaskWithDeviceModel:(BleDataModel *)boxDeviceModel CompleteHandler:(SimpleBlock)handler;

/**
 获取解绑设备任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getDisBindDeviceTaskWithboxDeviceModel:(BleDataModel *)boxDeviceModel CompleteHandler:(SimpleBlock)handler;

/**
 获取添加服药计划任务
 @param takePlanIds 计划
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getAddPlanTaskWithPlan:(NSArray<BleDataModel *> *)takePlanIds CompleteHandler:(SimpleBlock)handler;

/**
 获取删除服药计划任务
 @param takePlanIds 计划
 @param handler 务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)deletePlanTaskWithPlan:(NSArray<BleDataModel *> *)takePlanIds CompleteHandler:(SimpleBlock)handler;

/**
 获取删除服药计划任务
 @param oldPlanArr 旧计划
 @param newPlanArr 新计划
 @param oldPos 旧药仓
 @param handler 务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)editPlanTaskWithPlan:(NSArray<BleDataModel *> *)oldPlanArr newPlan:(NSArray<BleDataModel *> *)newPlanArr oldPos:(NSArray<NSNumber *> *)oldPos CompleteHandler:(SimpleBlock)handler;

/**
 获取控制灯光任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getLightControlTask:(NSInteger)lightType flashStyle:(NSInteger)flashStyle totalTime:(NSInteger)totalTime CompleteHandler:(SimpleBlock)handler;

/**
 获取预填药任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getFillMedicTask:(NSArray *)postions CompleteHandler:(SimpleBlock)handler;

/**
 监听药盒的开关盖动作
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)notifyPostionStateTaskCompleteHandler:(PostionStateSimpleBlock)handler;

/**
 获取语音点阵发送任务
 @param data 数据
 @param positionNo 仓位
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getVoiceLatticeTaskWithData:(NSData *)data dataType:(DataType)type positionNo:(NSString *)positionNo CompleteHandler:(SimpleBlock)handler;


/**
 移除监听药盒的开关盖动作
 */
- (void)removeNotifyPostionStateCommand;



@end

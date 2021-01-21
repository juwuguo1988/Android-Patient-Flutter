//
//  ThirdDeviceInterface.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/1.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewBleTask.h"
#import "NewBlockBlocks.h"

@protocol ThirdDeviceInterface <NSObject>

@optional
/**
 获取 获取医嘱数据操作 任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getQueryDevicePlansCompleteHandler:(SimpleBlock)handler;

/**
 获取 方便用户临时弹性调整服药计划提醒 任务
 @param delayPlans 延迟计划
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getMedicationReminderWithDelayPlans:(NSArray<BleDataModel *> *)delayPlans CompleteHandler:(SimpleBlock)handler;

/**
 获取 请求获取 Box 仓位状态数据  和  药盒药量感知 任务
 @param postions 仓位
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getPostionStateCommandWithPostions:(NSArray *)postions CompleteHandler:(SimpleBlock)handler;

/**
 获取药盒药量感知 任务
 @param postions 仓位
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getCellWeightCommandWithPostions:(NSArray *)postions CompleteHandler:(SimpleBlock)handler;

/**
 获取  药盒正反（放置）状态 任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getBoxStateCommandCompleteHandler:(SimpleBlock)handler;

/**
 获取 药盒地理位置 任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getBoxLoactionCompleteHandler:(SimpleBlock)handler;

/**
 获取 药盒运营商网络信号强度 任务
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getBoxNetSigalCompleteHandler:(SimpleBlock)handler;

/**
 获取 药盒时钟校正 任务
 @param ts 时间
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getCheckTimeWithTime:(long long)ts CompleteHandler:(SimpleBlock)handler;

/**
 获取 药盒震动控制 任务
 @param shakeStyle 震动方式，0：关闭震动， 1：开启震动，一直震动下去，2：500ms间隔震动，3：1000ms间隔震动
 @param totalTime 单位ms(毫秒)  开启震动后维持的总时长(shakeStyle==0时，此值为0)
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getShakeWithShakeStyle:(NSInteger)shakeStyle totalTime:(NSInteger)totalTime model:(NSInteger)model CompleteHandler:(SimpleBlock)handler;

/**
 获取 药盒扬声器（语音）控制 任务
@param sountType 语音类型 ， 0：关闭正在播放的语音，其他语音类型由硬件按照序号1开始往后进行排列，告知我方开发人员即可,
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getSoundWithSountType:(NSInteger)sountType model:(NSInteger)model volume:(NSInteger)volume CompleteHandler:(SimpleBlock)handler;

/**
 获取 语音传输 预处理
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getWillSpeechWithCell:(NSInteger)cell len:(NSInteger)len CompleteHandler:(SimpleBlock)handler;

/**
 获取 文字阵列数据传输 预处理
 @param handler 任务执行完毕的回调
 @return 任务实例
 */
- (NewBleTask *)getFontTextWithCell:(NSInteger)cell len:(NSInteger)len CompleteHandler:(SimpleBlock)handler;


@end


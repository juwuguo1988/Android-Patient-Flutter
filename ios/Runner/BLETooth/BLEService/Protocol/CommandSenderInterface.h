//
//  CommandSenderInterface.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/21.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewBleTask.h"



@class BleDataModel;

@protocol CommandSenderInterface <NSObject>

@optional


/**
 请求获取药盒药量感知
 @param task 任务
 */
- (void)getDeviceBatteryCommand:(NewBleTask *)task;
/**
     绑定药盒指令
     @param task 任务
 */
- (void)bindDevice:(NewBleTask *)task boxDeviceModel:(BleDataModel *)boxDeviceModel;

/**
     解绑药盒指令
     @param task 任务
     @param boxId 药盒 【上网模块】地址
 */
- (void)disBindDevice:(NewBleTask *)task boxId:(NSString *)boxId;

/**
     添加医嘱数据操作
     @param task 任务
     @param planInfoArr 服药计划
 */
- (void)addPlanToDevice:(NewBleTask *)task planInfoArr:(NSArray<BleDataModel *> *)planInfoArr;

/**
      删除医嘱数据操作
      @param task 任务
      @param takePlanIds 服药计划
 */
- (void)deletePlanToDevice:(NewBleTask *)task planInfoArr:(NSArray<BleDataModel *> *)takePlanIds;

/**
      修改医嘱数据操作
      @param task 任务
      @param takePlan 旧服药计划
      @param newPlans 新服药计划
 */
- (void)editPlanToDevice:(NewBleTask *)task oldPlanArr:(NSArray<BleDataModel *> *)takePlan newPlans:(NSArray *)newPlans oldPos:(NSArray<NSNumber *> *)oldPos;

/**
 获取医嘱数据操作
 @param task 任务
 */
- (void)queryDevicePlans:(NewBleTask *)task;

/**
 方便用户临时弹性调整服药计划提醒
 @param task 任务
 */
- (void)medicationReminder:(NewBleTask *)task delayPlans:(NSArray<BleDataModel *> *)delayPlans;

/**
      预填药
      @param task 任务
      @param postions 仓号
 */
- (void)fillMedicineCommand:(NewBleTask *)task postions:(NSArray *)postions;

/**
 请求获取 Box 仓位状态数据
 @param task 任务
 */
- (void)getPostionStateCommand:(NewBleTask *)task postions:(NSArray *)postions;

/**
 请求获取药盒药量感知
 @param task 任务
 */
- (void)getCellWeightCommand:(NewBleTask *)task postions:(NSArray *)postions;

/**
      关注药盒开关盖动作
      @param task 任务
 */
- (void)notifyPostionStateCommand:(NewBleTask *)task;

/**
      移除药盒开关盖动作
 */
- (void)removeNotifyPostionState;

/**
 药盒正反（放置）状态
 @param task 任务
 */
- (void)getBoxStateCommand:(NewBleTask *)task;

/**
 药盒地理位置
 @param task 任务
 */
- (void)boxLoaction:(NewBleTask *)task;

/**
 药盒运营商网络信号强度
 @param task 任务
 */
- (void)boxNetSigal:(NewBleTask *)task;

/**
 药盒时钟校正
 @param task 任务
 */
- (void)checkTime:(NewBleTask *)task time:(long long)ts;

/**
 药盒震动控制
 @param task 任务
 @param shakeStyle 震动方式，0：关闭震动， 1：开启震动，一直震动下去，2：500ms间隔震动，3：1000ms间隔震动
 @param totalTime 单位ms(毫秒)  开启震动后维持的总时长(shakeStyle==0时，此值为0)
 @param model 模式，表示 0:情景模式控制;1:指令模式控制
 */
- (void)shake:(NewBleTask *)task shakeStyle:(NSInteger)shakeStyle totalTime:(NSInteger)totalTime model:(NSInteger)model;

/**
 药盒扬声器（语音）控制
 @param task 任务
 @param sountType 语音类型 ， 0：关闭正在播放的语音，其他语音类型由硬件按照序号1开始往后进行排列，告知我方开发人员即可,
 @param model 模式，表示 0:情景模式控制;1:指令模式控制
 @param volume 【两种模式下，此字段都表示， ⽤用值 0 ~ 100，表示控制⾳音量量从
 最⼩小⾄至最⼤大】
 */
- (void)sound:(NewBleTask *)task sountType:(NSInteger)sountType model:(NSInteger)model volume:(NSInteger)volume;

/**
      控制灯
      @param task 任务
      @param lightType 灯的类型 0:电源灯，1?:仓位灯(?==1,即1 号仓位灯，以此类推)
      @param flashStyle 闪亮⽅方式  1:开启常亮，⼀一直亮下去，2: 500ms间隔闪亮，3:1000ms间隔闪亮
      @param totalTime 单位ms(毫秒)  开启灯亮后维持的总时⻓长
 */
- (void)lightCommand:(NewBleTask *)task lightType:(NSInteger)lightType flashStyle:(NSInteger)flashStyle totalTime:(NSInteger)totalTime;

/**
 语音数据传输 预处理
 
 @param task 任务
 @param cell 药盒 作用的仓号
 @param len  //该条数据 控制后续是否（为0表示无后续二进制流）有二进制流的蓝牙数据包，有的话其值表示有?个数据包属于该数据的数据包
 */
- (void)WillSpeech:(NewBleTask *)task cell:(NSInteger)cell len:(NSInteger)len;

/**
 文字阵列数据传输 预处理
 
 @param task 任务
 @param cell 药盒 作用的仓号
 @param len  //该条数据 控制后续是否（为0表示无后续二进制流）有二进制流的蓝牙数据包，有的话其值表示有?个数据包属于该数据的数据包
 */
- (void)WillFontSend:(NewBleTask *)task cell:(NSInteger)cell len:(NSInteger)len;

- (void)voiceDataSend:(NewBleTask *)task data:(NSData *)data postion:(NSString *)postion;

- (void)latticeDataSend:(NewBleTask *)task data:(NSData *)data postion:(NSString *)postion;

- (void)personalVoice:(NewBleTask *)task data:(NSData *)data;

- (void)personalText:(NewBleTask *)task data:(NSData *)data;

@end


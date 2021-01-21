//
//  BleDataModel.h
//  Runner
//
//  Created by 周素华 on 1/7/2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BleDataModel : NSObject

@property (nonatomic, copy) NSString *mac;

@property (nonatomic, copy) NSString *customePlanId;
/** 药仓号 */
@property (nonatomic, copy) NSString *positionNo;
/** 提醒时间（时分在一天中的索引表示，如：6:30 即为 390） */
@property (nonatomic, copy) NSString *takeAt;
/** 单次服药规定服用数量 */
@property (nonatomic, copy) NSString *count;
/** 服药计划频率（单位：天数, 默认为0-每天服药，1-隔一天一服，-1 - 只吃一次的） */
@property (nonatomic, copy) NSString *cycleDays;
/** 服药计划 第一次生效时间毫秒值 */
@property (nonatomic, copy) NSString *remindFirstAt;
/** 剂型单位 */
@property (nonatomic, copy) NSString *dosageFormUnit;
/** 单次服药规定服用剂量 只接受int整型，所有数据*1000然后进行计算 */
@property (nonatomic, copy) NSString *dosage;


/** 音量 */
@property (nonatomic, copy) NSString *volume;
/** 音量 */
@property (nonatomic, assign) bool inShock;

/**【上网模块】地址 */
@property (nonatomic, copy) NSString *imei;

@end

NS_ASSUME_NONNULL_END

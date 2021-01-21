//
//  XZLNewPillBoxMessage.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/2/27.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BleDataModel;

@interface XZLNewPillBoxMessage : NSObject

@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, assign) NSInteger action;

@property (nonatomic, copy) NSString *systemVersion; //硬件定义

@property (nonatomic, copy) NSString *ts;

@end


@interface XZLNewPillBoxBindUnBindMessage : XZLNewPillBoxMessage

@property (nonatomic, assign) NSInteger actionPriority; //优先级操作(优先级更高的指令 覆盖优先级低的指令进行执行) 值越大优先级越高 默认为0

@end

@interface XZLNewPillBoxBindMessage : XZLNewPillBoxMessage

@property (nonatomic, assign) NSInteger actionPriority; //优先级操作(优先级更高的指令 覆盖优先级低的指令进行执行) 值越大优先级越高 默认为0

@property (nonatomic, assign) NSInteger shakeStyle;


@property (nonatomic, assign) NSInteger volume;


@end


@interface XZLNewPillBoxAddPlanMessage : XZLNewPillBoxMessage

@property (nonatomic, strong) NSArray *plans;

@end

/**
 服药计划的一般性数据模型
 */
@interface XZLNewPillBoxPlanModel : NSObject

/**  */
@property (nonatomic, copy) NSString *_id;
/**  */
@property (nonatomic, strong) NSArray *position;
/** 必须为整型  */
@property (nonatomic, assign) NSInteger rang;
/** 必须为整型 */
@property (nonatomic, assign) NSInteger count;
/** 必须为整型 */
@property (nonatomic, assign) NSInteger recycle;
/** 必须为整型 */
@property (nonatomic, assign) long long startedAt;
//剂型单位，"片"、"袋"、"粒"、"丸"
//@property (nonatomic, assign) NSInteger dosageFormUnit;
@property (nonatomic, copy) NSString *dosageFormUnit;

//剂型单位，"片"、"袋"、"粒"、"丸"
@property (nonatomic, assign) NSInteger dosageUnit;

+ (XZLNewPillBoxPlanModel *)mqttPlanModel:(BleDataModel *)medicinePlan addedTime:(long long)time;

@end

@interface XZLNewPillBoxDeletePlanMessage : XZLNewPillBoxMessage

@property (nonatomic, strong) NSArray *planIds;

@property (nonatomic, strong) NSArray *position;

@end


@interface XZLNewPillBoxModifyPlanMessage : XZLNewPillBoxAddPlanMessage

@property (nonatomic, strong) NSArray *oldPlanIds;

@property (nonatomic, strong) NSArray *oldPos;

@end


@interface XZLNewPillBoxFillCellCommand : XZLNewPillBoxMessage

@property (nonatomic, strong) NSArray *position;

//关键字 前面自己加上_,对应的code文件也加上了_
@property (nonatomic, assign) NSInteger _auto;

@end

@interface XZLNewPillBoxControlLightMessage : XZLNewPillBoxMessage

// 灯的类型，0：电源灯，1?：仓位灯(?==1,即1号仓位灯，以此类推)
@property (nonatomic, assign) NSInteger lightType;
// 闪亮方式，1：开启常亮，一直亮下去，2：500ms间隔闪亮，3：1000ms间隔闪亮
@property (nonatomic, assign) NSInteger flashStyle;
//单位ms(毫秒)， 开启灯亮后维持的总时长
@property (nonatomic, assign) NSInteger totalTime;

@end


@interface XZLNewPillBoxWillSpeechMessage : XZLNewPillBoxMessage

//该条业务数据 作用的仓号(数值)
@property (nonatomic, assign) NSInteger cell;
//该条数据 控制后续二进制流的起始位置(默认为0)
@property (nonatomic, assign) NSInteger pos;
//该条数据 控制后续是否（为0表示无后续二进制流）有二进制流的蓝牙数据包，有的话其值表示有?个数据包属于该数据的数据包
@property (nonatomic, assign) NSInteger len;

@end


@interface XZLNewPillBoxFontTextMessage : XZLNewPillBoxWillSpeechMessage


@end


@interface XZLNewPillBoxMedicineReminderMessage : XZLNewPillBoxMessage

@property (nonatomic, strong) NSArray *plans;

@end


@interface XZLNewPillBoxCheckTimeMessage : XZLNewPillBoxMessage

@property (nonatomic, assign) long long ts;

@end


@interface XZLNewPillBoxShakeMessage : XZLNewPillBoxMessage

/// 情景模式下 - 震动⽅方式，0:震动常关， 1:震动常开
// 指令模式下 - 震动⽅方式，0:关闭震动， 1:开启震动，⼀一直震动下去，2:500ms间隔震动，3:1000ms间隔震动
@property (nonatomic, assign) NSInteger shakeStyle;

@property (nonatomic, assign) NSInteger totalTime;

@property (nonatomic, assign) NSInteger model; // 0:情景模式控制;1:指令模式控制

@end


@interface XZLNewPillBoxSoundMessage : XZLNewPillBoxMessage

//【情景模式下，此字段表示， 0: 常关;1，常开。】
//【指令模式下，此字段表示，0:关闭正在播放的语⾳音，其他⼤大于0的值表示播放语⾳音，且语⾳音的内容类型由硬件按照序号1开始往后进⾏行行排列列，告知我⽅方开发⼈人员即可】
@property (nonatomic, assign) NSInteger sountType;

@property (nonatomic, assign) NSInteger model; // 0:情景模式控制;1:指令模式控制

@property (nonatomic, assign) NSInteger volume; // 【两种模式下，此字段都表示， ⽤用值 0 ~ 100，表示控制⾳音量量从最⼩小⾄至最⼤大】

@end


// 药盒返回model 简单响应包括查询医嘱的简单响应

@interface XZLNewPillBoxResponSimpleMessage : XZLNewPillBoxMessage // 成功响应、失败响应

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *_description; // 如果是成功简单响应就为nil

@property (nonatomic, copy) NSString *batteryRemain;

@property (nonatomic, strong) NSArray *plans; // REQ_GET_DOCTOR_ADVICE指令查询到的服药医嘱id列列表

@end

// 请求获取 Box 仓位状态数据 药盒返回数据
@interface XZLNewPillBoxNotifyPostionStateMessage : XZLNewPillBoxMessage

@property (nonatomic, assign) NSInteger position;

// 仓盖状态:0:关闭，1:打开
@property (nonatomic, assign) NSInteger cellCover;

// 自定义私用
//@property (nonatomic, assign) NSInteger state;

@end

@class XZLNewPillBoxState;
@class XZLNewPillBoxLocation;
// 【获取服药记录使⽤用】App 或 Cloud 请求获取 Box 仓位状态数据的回应
@interface XZLNewPillBoxResponPostionStateMessage : XZLNewPillBoxMessage

@property (nonatomic, assign) NSInteger boxState;

// 仓盖状态:0:关闭，1:打开
@property (nonatomic, assign) XZLNewPillBoxState *stateList;

@property (nonatomic, assign) XZLNewPillBoxLocation *location;

// 自定义私用
@property (nonatomic, assign) NSInteger state;

@end


@interface XZLNewPillBoxState : NSObject // 成功响应、失败响应

//仓号(注意这⾥里里，并不不按照仓位共享规则返回数 据，还是单仓统计)
@property (nonatomic, assign) NSInteger position;

//记录序号 递增计算， 初始值为1
@property (nonatomic, copy) NSString *recordId;

// 服药计划id，添加服 药计划时传过来的
@property (nonatomic, strong) NSArray *planIds;

// 仓盖状态:0:关闭，1:打开
@property (nonatomic, assign) NSInteger cellCover;

//药量量 mg (药品当前重量量)
@property (nonatomic, assign) NSInteger pillMeasure;

// 开/关盖时候的时间
@property (nonatomic, assign) NSInteger takeTime;

// 标记该次操作的操作类型 : 0:填药操作， 1:已经服药， 2:检测未服药
@property (nonatomic, assign) NSInteger opType;

// 该操作记录，属于哪个服药计划id，如果没有计算结果则赋值为 NULL
@property (nonatomic, copy) NSString *belongPlanId;

@end


@interface XZLNewPillBoxLocation : NSObject

//国家码 中国是460
@property (nonatomic, assign) NSInteger mcc;

//服务提供商码
@property (nonatomic, assign) NSInteger mnc;

@property (nonatomic, assign) NSInteger lac;

@property (nonatomic, assign) NSInteger ci;

@end

// 请求获取 药盒药量量感知 药盒返回数据
@interface XZLNewPillBoxResponCellWeightMessage : XZLNewPillBoxMessage

@property (nonatomic, copy) NSString *batteryRemain;

@property (nonatomic, strong) NSDictionary *content; // "1": 20, // 仓号:重量量值 [单位默认为 mg(毫克)]

@end


// 请求获取 药盒药量量感知 药盒返回数据
@interface XZLNewPillBoxResponBoxStateMessage : XZLNewPillBoxMessage

@property (nonatomic, copy) NSString *batteryRemain;

@property (nonatomic, assign) NSInteger boxState; //重⼒力力感应器器原始值,和硬件商定为 ⻆角度 数值

@end


// 请求获取 药盒电量
@interface XZLNewPillBoxResponBatteryMessage : XZLNewPillBoxMessage

@property (nonatomic, copy) NSString *batteryRemain;

// 电量的属于自定义
@property (nonatomic, assign) NSInteger state;

@end

// 请求获取 药盒电量
@interface XZLNewPillBoxResponDeletePlan : XZLNewPillBoxMessage

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *batteryRemain;

@property (nonatomic, assign) NSInteger boxState;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, copy) NSString *_description; // 如果是成功简单响应就为nil

@end


#pragma mark ---- 3代药盒操作记录
/*
 【是否向服务器确认】收到一条新消息 /app-8mZJn5: {"action":"V3_CONFIRM_RECORD","clientId":"860344047867305","planId":"l1zzX8","patientId":"8mZJn5","confirmAt":1563161311000}
 */
@interface XZLNewPillBoxOperationRecord : NSObject
    
@property (nonatomic, copy) NSString *clientId; // 860344047867305
    
@property (nonatomic, copy) NSString *action; //V3_CONFIRM_RECORD
    
@property (nonatomic, copy) NSString *planId;
    
@property (nonatomic, copy) NSString *patientId;

@property (nonatomic, strong) NSNumber *confirmAt;
    
@end

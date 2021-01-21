//
//  NewDeviceConstants.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#ifndef NewDeviceConstants_h
#define NewDeviceConstants_h


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DeviceType) {
    
    DT_Unknown = 0,         // 未知设备或全部设备
    DT_ThreePillBox,        // 3代药盒
};

typedef NS_ENUM(UInt8, ActionID) {
    
    // @"CONTROL_CHECK_NETWORK" //检查控制 Box进⾏行行联⽹网简历连接操作 三代药盒暂时不不考虑)
    CheckTimeAction     = 2,  // @"CONTROL_CHECK_TIME" 十三、药盒时钟校正 ?            简单响应
    DelayPlanAction     = 3,  // @"CONTROL_DELAY_PLAN" 六、服药提醒                   简单响应
    LightAction         = 4,  // @"CONTROL_LIGHT" 十六、药盒功能灯控制                 无响应
    ShakeAction         = 5,  // @"CONTROL_SHAKE" 十四、药盒震动控制 ?                 简单响应
    SoundAction         = 6,  // @"CONTROL_SOUND" 十五、药盒扬声器（语音）控制 ?         简单响应
    
                              // @"CONTROL_SYNC_HEALTH_DATA" 文档还没有关于他的数据格式
                              // @"ERROR" 异常信息提示给Cloud
    FontText            = 9,  // @"FONTDATA_PRE_HANDLE" 二十一、文字阵列数据传输         简单响应
    NotifyCellState     = 10, // @"NOTIFY_CELL_STATE" Box主动通知仓位状态数据  XZLNewPillBoxResponPostionStateMessage
                              // @“NOTIFY_DATA_HEALTH_CHECK” MQTT
    NotifyFullBattery   = 12, // @"NOTIFY_FULL_BATTERY" 满电                        (主动上报)简单响应 -- 未往外抛
    NOtifyGradBattery   = 13, // @"NOTIFY_GRADIENT_BATTERY" 充电梯度                 (主动上报)简单响应 -- 未往外抛
    NOtifyInBattery     = 14, // @"NOTIFY_IN_BATTERY" 插入电                         (主动上报)简单响应 -- 未往外抛
                              // @"NOTIFY_LOW_BATTERY" 文档还没有关于他的数据格式
    NOtifyOutBattery    = 16, // @"NOTIFY_OUT_BATTERY" 拔出切断电源                   (主动上报)简单响应 -- 未往外抛
    AddPlanAction       = 17, // @"REQ_ADD_DOCTOR_ADVICE" // 五、医嘱操作(服药计划)      简单响应
    BindDeviceAction    = 18, // @"REQ_BOX_BINDING"  // 四、绑定和解绑                  简单响应
                              // @"REQ_BOX_INFO" 十⼋、获取药盒基本信息(暂⽆)             无响应
    BoxStateAction      = 20, // @"REQ_BOX_STATE" // 十、药盒正反（放置）状态  XZLNewPillBoxResponBoxStateMessage
    UnBindDeviceAction  = 21, // @"REQ_BOX_UNLOCK_BINDING"  // 四、绑定和解绑           简单响应
    PositionStateAction = 22, // @"REQ_CELL_STATE"  // 八、药盒仓位状态    XZLNewPillBoxResponPostionStateMessage
    DeletePlanAction    = 23, // @"REQ_DEL_DOCTOR_ADVICE"  // 五、医嘱操作(服药计划)     简单响应
    FillMedicAction     = 24, // @"REQ_FILL_CELL"  // 七、填药操作指示
    QueryPlanAction     = 25, // @"REQ_GET_DOCTOR_ADVICE"  // 五、医嘱操作(服药计划)     简单响应
    GetNowBattery       = 26, // @"REQ_NOW_BATTERY" // 药盒电源和电量      XZLNewPillBoxResponBatteryMessage
    BoxLoactionAction   = 27, // @"REQ_NOW_LOCATION" // 十一、药盒地理位置 ？            未实现
    BoxNetSigalAction   = 28, // @"REQ_NOW_NETSIGNAL"  // 十二、药盒运营商网络信号强度 ?   未实现
    ModifyPlanAction    = 29, // @"REQ_UPDATE_DOCTOR_ADVICE" // 五、医嘱操作(服药计划)   简单响应
    RespBoxState        = 30, // @"RESP_BOX_STATE" 对药盒正反放置状态的响应               ------
    RespCellState       = 31, // @"RESP_CELL_STATE" Box 仓位状态数据的响应               ------
    RespSimpleFail      = 32, // @"RESP_FAIL"                                         ------
    RespNowBattery      = 33, // @"RESP_NOW_BATTERY" 获取药盒电量量数据的响应              ------
    RespNowLocation     = 34, // @"RESP_NOW_LOCATION" 药盒定位服务数据的响应               ------
    RespNowNetSignal    = 35, // @"RESP_NOW_NETSIGNAL" 网络信号数据的响应                 ------
    RespSimpleSuccess   = 36, // @"RESP_SUCCESS"    成功响应                            ------
    WillSpeeh           = 37, // @"VOICEDATA_PRE_HANDLE" // 二十、语音数据传输          简单响应
    NotifyBoxState      = 38, // @"NOTIFY_BOX_STATE"  对药盒正反放置状态的响应           (主动上报)未实现  -- 未往外抛
    CellWeightAction    = 39, // @"REQ_CELL_WEIGHT"  九、药盒药量感知  XZLNewPillBoxResponCellWeightMessage
    RespCellWeight      = 40, // @"RESP_CELL_WEIGHT"                                   ------
    PillBoxOpen         = 41, // @"开机"
    PillBoxClose        = 42, // @"关机"
    RespPersonVoice     = 43, // 个人信息语音
    RespPersonFont      = 44, // 个人信息文字
};


#define newBleCenterQueue dispatch_queue_create("com.newBle.bt", DISPATCH_QUEUE_SERIAL)

#define SecondDeviceTest 0

// 十七、药盒关机、重启控制（暂无）
// 十八、获取药盒基本信息（暂无）
// 十九、固件升级（远程IoT升级）

#endif /* NewDeviceConstants_h */

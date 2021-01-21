//
//  SecondPillBoxDevice.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/10.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "ThirdPillBoxDevice.h"
#import "ConnectService.h"
#import "BT_BindDevice.h"
#import "BT_UnBindDevice.h"
#import "BT_AddPlanTask.h"
#import "BT_DeletePlanTask.h"
#import "BT_EditPlanTask.h"
#import "BT_LightControlTask.h"
#import "BT_FillMedicTask.h"
#import "BT_PostionStateTask.h"
#import "BT_WillSpeech.h"
#import "BT_WillFontText.h"
#import "BT_QueryDevicePlans.h"
#import "BT_MedicationReminder.h"
#import "BT_PostionStatePillMeasure.h"
#import "BT_BoxState.h"
#import "BT_BoxLocation.h"
#import "BT_BoxNetSigal.h"
#import "BT_checkTimeTask.h"
#import "BT_ShakeBoxTask.h"
#import "BT_SoundControl.h"
#import "BT_GetDeviceBattery.h"
#import "BT_GetCellWeight.h"
#import "ThirdCommandSender.h"
#import "BleDataModel.h"
#import "BT_VoiceSendTask.h"

@implementation ThirdPillBoxDevice

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    
    self = [super initWithPeripheral:peripheral];
    if (self) {
        
        self.commandSender = [[ThirdCommandSender alloc] init];
        self.type = DT_ThreePillBox;
    }
    return self;
}

- (NewBleTask *)getConnectTaskWithCompleteHandler:(SimpleBlock)handler {
    
    BT_Connect *task = [[ConnectService sharedInstance] getConnectTaskForDevice:self];
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getDisconnectTaskWithCompleteHandler:(SimpleBlock)handler {
    
    BT_Disconnect *task = [[ConnectService sharedInstance] getDisconnectTaskForDevice:self];
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getDeviceBatteryTaskWithCompleteHandler:(SimpleBlock)handler {
    
    BT_GetDeviceBattery *task = [[BT_GetDeviceBattery alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getBindDeviceTaskWithDeviceModel:(BleDataModel *)boxDeviceModel CompleteHandler:(SimpleBlock)handler {
    
    BT_BindDevice *task = [[BT_BindDevice alloc] init];
    task.device = self;
    task.completeHandler = handler;
    task.boxDeviceModel = boxDeviceModel;
    return task;
}

- (NewBleTask *)getDisBindDeviceTaskWithboxDeviceModel:(BleDataModel *)boxDeviceModel CompleteHandler:(SimpleBlock)handler {
    
    BT_UnBindDevice *task = [[BT_UnBindDevice alloc] init];
    task.device = self;
    task.boxId = boxDeviceModel.imei;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getAddPlanTaskWithPlan:(NSArray<BleDataModel *> *)takePlanIds CompleteHandler:(SimpleBlock)handler {
    
    BT_AddPlanTask *task = [[BT_AddPlanTask alloc] init];
    task.device = self;
    task.takePlanIds = takePlanIds;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)deletePlanTaskWithPlan:(NSArray<BleDataModel *> *)takePlanIds CompleteHandler:(SimpleBlock)handler {
    
    BT_DeletePlanTask *task = [[BT_DeletePlanTask alloc] init];
    task.device = self;
    task.takePlanIds = takePlanIds;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)editPlanTaskWithPlan:(NSArray<BleDataModel *> *)oldPlanArr newPlan:(NSArray<BleDataModel *> *)newPlanArr oldPos:(NSArray<NSNumber *> *)oldPos CompleteHandler:(SimpleBlock)handler {
    
    BT_EditPlanTask *task = [[BT_EditPlanTask alloc] init];
    task.device = self;
    task.oldPlanArr = oldPlanArr;
    task.nowPlanArr = newPlanArr;
    task.oldPos = oldPos;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getQueryDevicePlansCompleteHandler:(SimpleBlock)handler {
    
    BT_QueryDevicePlans *task = [[BT_QueryDevicePlans alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getMedicationReminderWithDelayPlans:(NSArray<BleDataModel *> *)delayPlans CompleteHandler:(SimpleBlock)handler {
    
    BT_MedicationReminder *task = [[BT_MedicationReminder alloc] init];
    task.device = self;
    task.completeHandler = handler;
    task.delayPlans = delayPlans;
    return task;
}

- (NewBleTask *)getPostionStateCommandWithPostions:(NSArray *)postions CompleteHandler:(SimpleBlock)handler {
    
    BT_PostionStatePillMeasure *task = [[BT_PostionStatePillMeasure alloc] init];
    task.device = self;
    task.completeHandler = handler;
    task.postions = postions;
    return task;
}

- (NewBleTask *)getCellWeightCommandWithPostions:(NSArray *)postions CompleteHandler:(SimpleBlock)handler {
    
    BT_GetCellWeight *task = [[BT_GetCellWeight alloc] init];
    task.device = self;
    task.completeHandler = handler;
    task.postions = postions;
    return task;
}

- (NewBleTask *)getBoxStateCommandCompleteHandler:(SimpleBlock)handler {
    
    BT_BoxState *task = [[BT_BoxState alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getBoxLoactionCompleteHandler:(SimpleBlock)handler {
    
    BT_BoxLocation *task = [[BT_BoxLocation alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getBoxNetSigalCompleteHandler:(SimpleBlock)handler {
    
    BT_BoxNetSigal *task = [[BT_BoxNetSigal alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getCheckTimeWithTime:(long long)ts CompleteHandler:(SimpleBlock)handler {
    
    BT_checkTimeTask *task = [[BT_checkTimeTask alloc] init];
    task.device = self;
    task.ts = ts;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getShakeWithShakeStyle:(NSInteger)shakeStyle totalTime:(NSInteger)totalTime model:(NSInteger)model CompleteHandler:(SimpleBlock)handler {
    
    BT_ShakeBoxTask *task = [[BT_ShakeBoxTask alloc] init];
    task.device = self;
    task.shakeStyle = shakeStyle;
    task.totalTime = totalTime;
    task.model = model;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getSoundWithSountType:(NSInteger)sountType model:(NSInteger)model volume:(NSInteger)volume CompleteHandler:(SimpleBlock)handler {
    
    BT_SoundControl *task = [[BT_SoundControl alloc] init];
    task.device = self;
    task.sountType = sountType;
    task.completeHandler = handler;
    task.volume = volume;
    task.model = model;
    return task;
}

- (NewBleTask *)notifyPostionStateTaskCompleteHandler:(PostionStateSimpleBlock)handler {
    
    BT_PostionStateTask *task = [[BT_PostionStateTask alloc] init];
    task.device = self;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getVoiceLatticeTaskWithData:(NSData *)data dataType:(DataType)type positionNo:(NSString *)positionNo CompleteHandler:(SimpleBlock)handler {
    
    BT_VoiceSendTask *task = [[BT_VoiceSendTask alloc] init];
    task.device = self;
    task.data = data;
    task.dataType = type;
    task.positionNo = positionNo;
    task.completeHandler = handler;
    return task;
}

- (void)removeNotifyPostionStateCommand {
    
    [self.commandSender removeNotifyPostionState];
}

- (NewBleTask *)getLightControlTask:(NSInteger)lightType flashStyle:(NSInteger)flashStyle totalTime:(NSInteger)totalTime CompleteHandler:(SimpleBlock)handler {
    
    BT_LightControlTask *task = [[BT_LightControlTask alloc] init];
    task.device = self;
    task.lightType = lightType;
    task.flashStyle = flashStyle;
    task.totalTime = totalTime;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getFillMedicTask:(NSArray *)postions CompleteHandler:(SimpleBlock)handler {
    
    BT_FillMedicTask *task = [[BT_FillMedicTask alloc] init];
    task.device = self;
    task.postions = postions;
    task.completeHandler = handler;
    return task;
}



- (NewBleTask *)getWillSpeechWithCell:(NSInteger)cell len:(NSInteger)len CompleteHandler:(SimpleBlock)handler {
    
    BT_WillSpeech *task = [[BT_WillSpeech alloc] init];
    task.device = self;
    task.cell = cell;
    task.len = len;
    task.completeHandler = handler;
    return task;
}

- (NewBleTask *)getFontTextWithCell:(NSInteger)cell len:(NSInteger)len CompleteHandler:(SimpleBlock)handler {
    
    BT_WillFontText *task = [[BT_WillFontText alloc] init];
    task.device = self;
    task.cell = cell;
    task.len = len;
    task.completeHandler = handler;
    return task;
}


@end

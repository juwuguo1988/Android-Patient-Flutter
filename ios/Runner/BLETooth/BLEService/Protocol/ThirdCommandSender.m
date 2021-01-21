//
//  ThirdCommandSender.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/21.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "ThirdCommandSender.h"
#import "XZLNewPillBoxMessage.h"
//#import "XZLPillBoxAddPlansMessage.h"
//#import "XZLPillBoxFillCellCommand.h"
//#import "XZLControlBoxLight.h"
#import "BaseDeviceTask.h"
//#import "BleDataModel.h"
#import "MJExtension.h"
#import "BleDataModel.h"

@interface ThirdCommandSender()

@property (nonatomic, strong) NSMutableDictionary *keyCodeDic;

@end


@implementation ThirdCommandSender

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"ThirdMedicCode"
                                                       ofType:@"plist"];
        _keyCodeDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

- (void)getDeviceBatteryCommand:(NewBleTask *)task {
    
    XZLNewPillBoxMessage *boxMessage = [[XZLNewPillBoxMessage alloc] init];
    
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = GetNowBattery;
    
    [[CommandParser sharedInstance] appendTask:task taskId:GetNowBattery];
     
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---getDeviceBatteryCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)bindDevice:(NewBleTask *)task boxDeviceModel:(BleDataModel *)boxDeviceModel {
    
    XZLNewPillBoxBindMessage *boxMessage = [[XZLNewPillBoxBindMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = BindDeviceAction;
    boxMessage.actionPriority = 100;
    boxMessage.volume = [boxDeviceModel.volume intValue];
    boxMessage.shakeStyle = [[NSString stringWithFormat:@"%d",boxDeviceModel.inShock] intValue];
    
    [[CommandParser sharedInstance] appendTask:task taskId:BindDeviceAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---bindDevice-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)disBindDevice:(NewBleTask *)task boxId:(NSString *)boxId {
    
    XZLNewPillBoxBindUnBindMessage *boxMessage = [[XZLNewPillBoxBindUnBindMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = UnBindDeviceAction;
    boxMessage.actionPriority = 100;
    
    [[CommandParser sharedInstance] appendTask:task taskId:UnBindDeviceAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---disBindDevice-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)addPlanToDevice:(NewBleTask *)task planInfoArr:(NSArray<BleDataModel *> *)planInfoArr {
    
    XZLNewPillBoxAddPlanMessage *boxMessage = [[XZLNewPillBoxAddPlanMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = AddPlanAction;
    
    NSMutableArray *plans = [NSMutableArray array];
    for (BleDataModel *medicineInfo in planInfoArr) {
        
        [plans addObject:[XZLNewPillBoxPlanModel mqttPlanModel:medicineInfo addedTime:0]];
    }
    boxMessage.plans = plans;
    
    [[CommandParser sharedInstance] appendTask:task taskId:AddPlanAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---addPlanToDevice-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)deletePlanToDevice:(NewBleTask *)task planInfoArr:(NSArray<BleDataModel *> *)takePlanIds {
    
    XZLNewPillBoxDeletePlanMessage *boxMessage = [[XZLNewPillBoxDeletePlanMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = DeletePlanAction;
    NSMutableArray *plans = [NSMutableArray array];
    for (BleDataModel *medicineInfo in takePlanIds) {
         
        if (medicineInfo.customePlanId) {
            [plans addObject:medicineInfo.customePlanId];
        }
    }
    boxMessage.planIds = plans;
    boxMessage.position = @[takePlanIds.firstObject.positionNo];
    
    [[CommandParser sharedInstance] appendTask:task taskId:DeletePlanAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---deletePlanToDevice-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)editPlanToDevice:(NewBleTask *)task oldPlanArr:(NSArray<BleDataModel *> *)takePlan newPlans:(NSArray *)newPlans oldPos:(NSArray<NSNumber *> *)oldPos {
    
    XZLNewPillBoxModifyPlanMessage *boxMessage = [[XZLNewPillBoxModifyPlanMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = ModifyPlanAction;
    boxMessage.oldPos = oldPos;
    
    NSMutableArray *plans = [NSMutableArray array];
    long long addedTime = 0;
    for (BleDataModel *medicineInfo in newPlans) {
         
        [plans addObject:[XZLNewPillBoxPlanModel mqttPlanModel:medicineInfo addedTime:addedTime]];
    }
    boxMessage.plans = plans;
    
    if ([takePlan.lastObject isKindOfClass:[NSString class]]) {
        boxMessage.oldPlanIds = takePlan;
    } else {
        NSMutableArray *oldPlanIds = [NSMutableArray array];
        for (BleDataModel *medicineInfo in takePlan) {
            [oldPlanIds addObject:medicineInfo.customePlanId];
        }
        boxMessage.oldPlanIds = oldPlanIds;
    }
   
    [[CommandParser sharedInstance] appendTask:task taskId:ModifyPlanAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---editPlanToDevice-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)queryDevicePlans:(NewBleTask *)task {
    
    XZLNewPillBoxMessage *boxMessage = [[XZLNewPillBoxMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = QueryPlanAction;
    
    [[CommandParser sharedInstance] appendTask:task taskId:QueryPlanAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---queryDevicePlans-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
        [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)medicationReminder:(NewBleTask *)task delayPlans:(NSArray<BleDataModel *> *)delayPlans {
    
    XZLNewPillBoxMedicineReminderMessage *boxMessage = [[XZLNewPillBoxMedicineReminderMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = DelayPlanAction;
    boxMessage.plans = delayPlans;
    
    [[CommandParser sharedInstance] appendTask:task taskId:DelayPlanAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---medicationReminder-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)fillMedicineCommand:(NewBleTask *)task postions:(NSArray *)postions {

    XZLNewPillBoxFillCellCommand *boxMessage = [[XZLNewPillBoxFillCellCommand alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = FillMedicAction;
    boxMessage._auto = 1;
    boxMessage.position = postions;
    
    [[CommandParser sharedInstance] appendTask:task taskId:FillMedicAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---fillMedicineCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)getPostionStateCommand:(NewBleTask *)task postions:(NSArray *)postions {
    
    XZLNewPillBoxFillCellCommand *boxMessage = [[XZLNewPillBoxFillCellCommand alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = PositionStateAction;
    boxMessage.position = postions;
    
    [[CommandParser sharedInstance] appendTask:task taskId:PositionStateAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---getPostionStateCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)getCellWeightCommand:(NewBleTask *)task postions:(NSArray *)postions {
    
    XZLNewPillBoxFillCellCommand *boxMessage = [[XZLNewPillBoxFillCellCommand alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = CellWeightAction;
    boxMessage.position = postions;
    
    [[CommandParser sharedInstance] appendTask:task taskId:CellWeightAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---getCellWeightCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)notifyPostionStateCommand:(NewBleTask *)task {
    
    [[CommandParser sharedInstance] appendTask:task taskId:NotifyCellState];
}

- (void)removeNotifyPostionState {
    
     [[CommandParser sharedInstance] removeTaskId:NotifyCellState];
}

- (void)getBoxStateCommand:(NewBleTask *)task {
    
    XZLNewPillBoxMessage *boxMessage = [[XZLNewPillBoxMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = BoxStateAction;
    
    [[CommandParser sharedInstance] appendTask:task taskId:BoxStateAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---getBoxStateCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)boxLoaction:(NewBleTask *)task {
    
    XZLNewPillBoxMessage *boxMessage = [[XZLNewPillBoxMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = BoxLoactionAction;
    
    [[CommandParser sharedInstance] appendTask:task taskId:BoxLoactionAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---boxLoaction-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)boxNetSigal:(NewBleTask *)task {
    
    XZLNewPillBoxMessage *boxMessage = [[XZLNewPillBoxMessage alloc] init];
   [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = BoxNetSigalAction;
    
    [[CommandParser sharedInstance] appendTask:task taskId:BoxNetSigalAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---boxNetSigal-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)checkTime:(NewBleTask *)task time:(long long)ts {
    
    XZLNewPillBoxCheckTimeMessage *boxMessage = [[XZLNewPillBoxCheckTimeMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = CheckTimeAction;
    boxMessage.ts = ts;
    
    [[CommandParser sharedInstance] appendTask:task taskId:CheckTimeAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---checkTime-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)shake:(NewBleTask *)task shakeStyle:(NSInteger)shakeStyle totalTime:(NSInteger)totalTime model:(NSInteger)model {
    
    XZLNewPillBoxShakeMessage *boxMessage = [[XZLNewPillBoxShakeMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = ShakeAction;
    boxMessage.shakeStyle = shakeStyle;
    boxMessage.totalTime = totalTime;
    boxMessage.model = model;
    
    [[CommandParser sharedInstance] appendTask:task taskId:ShakeAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---shake-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)sound:(NewBleTask *)task sountType:(NSInteger)sountType model:(NSInteger)model volume:(NSInteger)volume {
 
    XZLNewPillBoxSoundMessage *boxMessage = [[XZLNewPillBoxSoundMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = SoundAction;
    boxMessage.sountType = sountType;
    boxMessage.model = model;
    boxMessage.volume = volume;
    
    [[CommandParser sharedInstance] appendTask:task taskId:SoundAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---sound-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)lightCommand:(NewBleTask *)task lightType:(NSInteger)lightType flashStyle:(NSInteger)flashStyle totalTime:(NSInteger)totalTime {
    
    XZLNewPillBoxControlLightMessage *boxMessage = [[XZLNewPillBoxControlLightMessage alloc] init];
   [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = LightAction;
    boxMessage.lightType = lightType;
    boxMessage.flashStyle = flashStyle;
    boxMessage.totalTime = totalTime;
    
    [[CommandParser sharedInstance] appendTask:task taskId:LightAction];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---lightCommand-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)WillSpeech:(NewBleTask *)task cell:(NSInteger)cell len:(NSInteger)len {
     
    XZLNewPillBoxWillSpeechMessage *boxMessage = [[XZLNewPillBoxWillSpeechMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = WillSpeeh;
    boxMessage.cell = cell;
    boxMessage.len = len;
    
    [[CommandParser sharedInstance] appendTask:task taskId:WillSpeeh];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---WillSpeech-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)WillFontSend:(NewBleTask *)task cell:(NSInteger)cell len:(NSInteger)len {
    
    XZLNewPillBoxFontTextMessage *boxMessage = [[XZLNewPillBoxFontTextMessage alloc] init];
    [self setDefaultData:boxMessage boxDeviceModel:((BaseDeviceTask *)task).device.boxDeviceModel];
    boxMessage.action = FontText;
    boxMessage.cell = cell;
    boxMessage.len = len;
    
    [[CommandParser sharedInstance] appendTask:task taskId:FontText];
    int result = [self.iOSSdk sendData:[boxMessage.mj_JSONString dataUsingEncoding:NSUTF8StringEncoding] withTid:BleSdkTaskIdJSON withSid:1];
    DDLogDebug(@"zhousuhua -result:%d---WillFontSend-json为:%@",result,boxMessage.mj_JSONString);
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdJSON errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)setDefaultData:(XZLNewPillBoxMessage *)boxMessage boxDeviceModel:(BleDataModel *)boxDeviceModel {
    
//    boxMessage.clientId = [NSString stringWithFormat:@"app-%@",XZLUserDefaultCenter.user.tel];
    boxMessage.systemVersion = @"0.0.1.190701";
    
    boxMessage.clientId = boxDeviceModel.imei;
    boxMessage.ts = [NSString stringWithFormat:@"%lld",[[self getNowTimestamp_DQExt] longLongValue] / 1000];
}

- (void)voiceDataSend:(NewBleTask *)task data:(NSData *)data postion:(NSString *)postion {
    
    char sid = [postion intValue];
    DDLogDebug(@"zhousuhua ---- 发送的语音data:%@ %@",data ,postion);
    [[CommandParser sharedInstance] appendTask:task taskId:WillSpeeh];
    int result = [self.iOSSdk sendData:data withTid:BleSdkTaskIdVoice withSid:sid];
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdVoice errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)latticeDataSend:(NewBleTask *)task data:(NSData *)data postion:(NSString *)postion {
    
    char sid = [postion intValue];
    DDLogDebug(@"zhousuhua ---- 发送的点阵data:%@ %@",data ,postion);
    [[CommandParser sharedInstance] appendTask:task taskId:FontText];
    int result = [self.iOSSdk sendData:data withTid:BleSdkTaskIdPixels withSid:sid];
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdPixels errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)personalVoice:(NewBleTask *)task data:(NSData *)data {
 
    DDLogDebug(@"zhousuhua ---- 发送的个人信息语音data:%@",data);
    [[CommandParser sharedInstance] appendTask:task taskId:RespPersonVoice];
    int result = [self.iOSSdk sendData:data withTid:BleSdkTaskIdPersonal withSid:2];
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdPersonal errorDes:@"药盒未连接，发送数据失败"];
    }
}

- (void)personalText:(NewBleTask *)task data:(NSData *)data {
 
    DDLogDebug(@"zhousuhua ---- 发送的个人信息文字data:%@",data);
    [[CommandParser sharedInstance] appendTask:task taskId:RespPersonFont];
    int result = [self.iOSSdk sendData:data withTid:BleSdkTaskIdPersonal withSid:1];
    if (result != 0) {
       [[CommandParser sharedInstance] sendFailTaskFlat:BleSdkTaskIdPersonal errorDes:@"药盒未连接，发送数据失败"];
    }
}


#pragma mark ---- 私有方法
- (NSArray *)getSameTimePlansOldPlan:(NSArray<BleDataModel *> *)takePlan newPlans:(NSArray *)newPlans {
    
    NSMutableArray *samePlansArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *oldPlanTimesDic = [[NSMutableDictionary alloc] init];
    for (BleDataModel *metaInfo in takePlan) {
        
        [oldPlanTimesDic setObject:metaInfo forKey:metaInfo.takeAt];
    }
    for (BleDataModel *metaInfo in newPlans) {
        
        BleDataModel *sameInfo = [oldPlanTimesDic objectForKey:metaInfo.takeAt];
        if (sameInfo) {
            [samePlansArr addObject:sameInfo];
        }
    }
    return samePlansArr;
}


//NSString *sendText = @"好的你们也是哦哈哈哈";
//
//unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//
//return [sendText dataUsingEncoding:encode];

/**
 获取当前时间戳
 */
- (NSString *)getNowTimestamp_DQExt {
    
    // 获取当前时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS Z";
    NSString *date = [fmt stringFromDate:[NSDate date]];
    
    // 将当前时间转时间戳
    NSString *timeStamp =
    [NSString stringWithFormat:@"%f",[[fmt dateFromString:date] timeIntervalSince1970] *1000];
    
    // 截取字符串
    NSRange range = [timeStamp rangeOfString:@"."];
    return [timeStamp substringToIndex:range.location];
}

@end

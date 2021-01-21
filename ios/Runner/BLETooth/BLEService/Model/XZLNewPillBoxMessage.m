//
//  XZLNewPillBoxMessage.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/2/27.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "XZLNewPillBoxMessage.h"
#import "BleDataModel.h"

@implementation XZLNewPillBoxMessage

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    NSString *path=[[NSBundle mainBundle] pathForResource:@"ThirdMedicCode"
                                                   ofType:@"plist"];

     return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

@end


@implementation XZLNewPillBoxBindUnBindMessage


@end

@implementation XZLNewPillBoxBindMessage


@end


@implementation XZLNewPillBoxAddPlanMessage

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"plans":[XZLNewPillBoxPlanModel class]};
}

@end


@implementation XZLNewPillBoxPlanModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"ThirdMedicCode"
                                                   ofType:@"plist"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

+ (XZLNewPillBoxPlanModel *)mqttPlanModel:(BleDataModel *)medicinePlan addedTime:(long long)time {
    
    XZLNewPillBoxPlanModel *mqttPlan = [[XZLNewPillBoxPlanModel alloc] init];
    mqttPlan._id = [[NSString alloc] initWithString:medicinePlan.customePlanId];
    mqttPlan.position = @[[NSNumber numberWithInteger:medicinePlan.positionNo.integerValue]];
    mqttPlan.rang = [medicinePlan.takeAt integerValue];
    mqttPlan.count = medicinePlan.count.integerValue / 10;
    mqttPlan.recycle = medicinePlan.cycleDays.integerValue + 1;
    mqttPlan.startedAt = medicinePlan.remindFirstAt.longLongValue / 1000 + time;
    
    if ([medicinePlan.dosageFormUnit isEqualToString:@"片"]) {
        
        mqttPlan.dosageFormUnit = @"1";  // 片1
    } else if ([medicinePlan.dosageFormUnit isEqualToString:@"粒"]) {
        
        mqttPlan.dosageFormUnit = @"2";  // 2粒
    } else if ([medicinePlan.dosageFormUnit isEqualToString:@"袋"]) {
        
        mqttPlan.dosageFormUnit = @"3";  // 3袋
    } else if ([medicinePlan.dosageFormUnit isEqualToString:@"丸"]) {
        
        mqttPlan.dosageFormUnit = @"4";  // 4丸
    } else if ([medicinePlan.dosageFormUnit isEqualToString:@"个"]) {
        
        mqttPlan.dosageFormUnit = @"5";  // 5个
    } else {
        
        mqttPlan.dosageFormUnit = @"1";
    }
    mqttPlan.dosageUnit = [medicinePlan.dosage integerValue];
    return mqttPlan;
}

@end


@implementation XZLNewPillBoxDeletePlanMessage


@end


@implementation XZLNewPillBoxModifyPlanMessage


@end


@implementation XZLNewPillBoxFillCellCommand


@end


@implementation XZLNewPillBoxControlLightMessage  


@end


@implementation XZLNewPillBoxWillSpeechMessage


@end


@implementation XZLNewPillBoxFontTextMessage


@end


@implementation XZLNewPillBoxMedicineReminderMessage


@end


@implementation XZLNewPillBoxCheckTimeMessage  


@end


@implementation XZLNewPillBoxShakeMessage


@end


@implementation XZLNewPillBoxSoundMessage


@end


@implementation XZLNewPillBoxResponSimpleMessage


@end


// 请求获取 Box 仓位状态数据 药盒返回数据
@implementation XZLNewPillBoxResponPostionStateMessage
 

@end


// 请求获取 Box 仓位状态数据 药盒返回数据
@implementation XZLNewPillBoxNotifyPostionStateMessage

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"stateList":[XZLNewPillBoxState class]};
}

@end



@implementation XZLNewPillBoxState

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"ThirdMedicCode"
                                                   ofType:@"plist"];
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}


@end


@implementation XZLNewPillBoxLocation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"ThirdMedicCode"
                                                   ofType:@"plist"];
    
    return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}


@end


@implementation XZLNewPillBoxResponCellWeightMessage

@end
 

@implementation XZLNewPillBoxResponBoxStateMessage

@end


@implementation XZLNewPillBoxResponBatteryMessage

@end

@implementation XZLNewPillBoxResponDeletePlan

@end

@implementation XZLNewPillBoxOperationRecord

@end


 

//
//  BT_MedicationReminder.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_MedicationReminder : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, strong) NSArray<BleDataModel *> *delayPlans;

@end

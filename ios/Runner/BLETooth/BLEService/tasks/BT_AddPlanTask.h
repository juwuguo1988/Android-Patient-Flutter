//
//  BT_AddPlanTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/24.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"

@class BleDataModel;

@interface BT_AddPlanTask : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, strong) NSArray<BleDataModel *> *takePlanIds;

@end


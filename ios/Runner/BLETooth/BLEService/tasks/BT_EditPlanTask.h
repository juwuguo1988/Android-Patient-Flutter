//
//  BT_editPlanTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/27.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_EditPlanTask : BaseDeviceTask
 
@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, strong) NSArray<BleDataModel *> *oldPlanArr;

@property (nonatomic, strong) NSArray<BleDataModel *> *nowPlanArr;

@property (nonatomic, strong) NSArray<NSNumber *> *oldPos;

@end

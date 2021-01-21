//
//  BT_BindDevice.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/19.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_BindDevice : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, strong) BleDataModel *boxDeviceModel;

@end


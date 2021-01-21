//
//  BT_checkTimeTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 

@interface BT_checkTimeTask : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, assign) long long ts;

@end


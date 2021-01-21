//
//  BT_SoundControl.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_SoundControl : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, assign) NSInteger sountType;

@property (nonatomic, assign) NSInteger model;

@property (nonatomic, assign) NSInteger volume;

@end


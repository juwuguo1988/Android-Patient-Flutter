//
//  BT_ShakeBoxTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/18.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 

@interface BT_ShakeBoxTask : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, assign) NSInteger shakeStyle;

@property (nonatomic, assign) NSInteger totalTime;

@property (nonatomic, assign) NSInteger model;

@end


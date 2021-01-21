//
//  BT_LightControlTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/25.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"

@interface BT_LightControlTask : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, assign) NSInteger lightType;

@property (nonatomic, assign) NSInteger flashStyle;

@property (nonatomic, assign) NSInteger totalTime;
 
@end

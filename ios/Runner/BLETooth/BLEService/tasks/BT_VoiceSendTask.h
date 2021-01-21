//
//  BT_VoiceSendTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/6/29.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"

@interface BT_VoiceSendTask : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, assign) DataType dataType;

@property (nonatomic, strong) NSData* data;

@property (nonatomic, strong) NSString* positionNo;

@end

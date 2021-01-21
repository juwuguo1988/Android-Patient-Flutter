//
//  BT_UnBindDevice.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/21.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"

@interface BT_UnBindDevice : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;
@property (nonatomic, copy) NSString *boxId;

@end


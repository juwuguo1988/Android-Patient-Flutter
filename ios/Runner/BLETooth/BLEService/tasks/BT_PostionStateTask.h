//
//  BT_PostionStateTask.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/25.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_PostionStateTask : BaseDeviceTask

@property (nonatomic, strong) PostionStateSimpleBlock completeHandler;

//-1表示超时结束
@property (nonatomic, assign) NSInteger pos;

@property (nonatomic, assign) NSInteger coverState;

@end

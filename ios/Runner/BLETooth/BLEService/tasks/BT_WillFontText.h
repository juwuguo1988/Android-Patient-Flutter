//
//  BT_WillFontText.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/4.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_WillFontText : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

//该条业务数据 作用的仓号(数值)
@property (nonatomic, assign) NSInteger cell;
//该条数据 控制后续二进制流的起始位置(默认为0)
@property (nonatomic, assign) NSInteger pos;
//该条数据 控制后续是否（为0表示无后续二进制流）有二进制流的蓝牙数据包，有的话其值表示有?个数据包属于该数据的数据包
@property (nonatomic, assign) NSInteger len;

@end

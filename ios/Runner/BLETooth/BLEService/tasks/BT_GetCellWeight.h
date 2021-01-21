//
//  BT_GetCellWeight.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/5/22.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "BaseDeviceTask.h"
 
@interface BT_GetCellWeight : BaseDeviceTask

@property (nonatomic, strong) SimpleBlock completeHandler;

@property (nonatomic, strong) NSArray *postions;

@end


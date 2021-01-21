//
//  NewBlockBlocks.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/6.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#ifndef NewBlockBlocks_h
#define NewBlockBlocks_h

typedef NS_ENUM(NSInteger, DataType) {
    
    VoiceType = 1,         // 语音
    FontTextType = 2,         // 点阵
    PersonVoiceType = 3,         // 个人信息语音
    PersonTextType = 4,         // 个人信息文字
};

@class NewBleResult;
@class Device;

typedef void(^GetDeviceHandler)(NewBleResult * _Nonnull result, __kindof Device * _Nullable device);

typedef void(^SimpleBlock)(NewBleResult * _Nonnull result);

typedef void(^PostionStateSimpleBlock)(NSInteger pos,NSInteger coverState);
//typedef void(^StartMeasureBlock)(NewBleResult * _Nonnull result, NSTimeInterval startTime);
//
//typedef void(^DeviceVersionBlock)(NewBleResult * _Nonnull result, NSString  * _Nonnull version);
//typedef void(^DeviceBatteryBlock)(NewBleResult * _Nonnull result, float battery);

#endif /* NewBlockBlocks_h */

//
//  ThirdCommandSender.h
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/21.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "CommandSender.h"

typedef NS_ENUM(NSInteger, XZLBleSdkTaskId) {
    
    BleSdkTaskIdUnKnow = 0,  // 未知
    BleSdkTaskIdVoice = 1, // 语音
    BleSdkTaskIdPixels = 2, // 点阵
    BleSdkTaskIdJSON = 3, // json
    BleSdkTaskIdPersonal = 4, // 个人信息
};

@class bleIOSSdk;
@interface ThirdCommandSender : CommandSender

@property (nonatomic, weak) bleIOSSdk *iOSSdk;

@end


//
//  XZLThirdDeviceBLEBusiness.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/8.
//  Copyright © 2019 xinzhili. All rights reserved.
//
 
#import "XZLThirdPillBoxBusinessInterface.h"
 
#import "NewBlockBlocks.h"

@interface XZLThirdDeviceBLEBusiness : NSObject <XZLThirdPillBoxBusinessInterface>

// 默认为NO
@property (nonatomic, assign) bool isSendDatas;
 

- (void)voiceLatticeSendPillBoxDevice:(BleDataModel *)boxDeviceModel data:(NSData *)data dataType:(DataType)type postion:(NSString *)postion andTimeout:(CGFloat)timeout times:(int)times sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack;

@end


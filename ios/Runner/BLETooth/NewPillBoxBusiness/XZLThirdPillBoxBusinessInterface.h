//
//  XZLThirdPillBoxBusinessInterface.h
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/13.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleDataModel.h"
#import "XZLPillBoxBusinessConst.h"
 
@protocol XZLThirdPillBoxBusinessInterface <NSObject>


/**
 根据药盒的设备数据模型【绑定】一个药盒设备 （同步阻塞操作）
 
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)bindOnePillBoxDevice:(BleDataModel *)boxDeviceModel
                  andTimeout:(CGFloat)timeout
                 sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                failCallBack:(BoxFailureResponseBlock)failCallBack;  // NS_NOESCAPE

@optional; 

/**
 获取药盒电源和电量量
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)getBatteryPillBoxDevice:(BleDataModel *)boxDeviceModel
                             andTimeout:(CGFloat)timeout
                            sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                           failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 服药提醒  方便用户临时弹性调整服药计划提醒
 @param boxDeviceModel 药盒设备模型
 @param delayPlans 延迟计划
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)medicationReminderPillBoxDevice:(BleDataModel *)boxDeviceModel
                           delayPlans:(NSArray<BleDataModel *> *)delayPlans
                           andTimeout:(CGFloat)timeout
                          sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                         failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
请求获取 Box 仓位状态数据
 @param postions 仓位
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)postionStateCommandPillBoxDevice:(BleDataModel *)boxDeviceModel
                                postions:(NSArray *)postions
                              andTimeout:(CGFloat)timeout
                             sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                            failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 请求获取药盒药量感知
 @param postions 仓位
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)cellWeightCommandPillBoxDevice:(BleDataModel *)boxDeviceModel
                                postions:(NSArray *)postions
                              andTimeout:(CGFloat)timeout
                             sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                            failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 获取 药盒正反（放置）状态 任务
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)boxStateCommandPillBoxDevice:(BleDataModel *)boxDeviceModel
                          andTimeout:(CGFloat)timeout
                         sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                        failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 药盒地理位置
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)boxLoactionPillBoxDevice:(BleDataModel *)boxDeviceModel
                          andTimeout:(CGFloat)timeout
                         sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                        failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 药盒运营商网络信号强度
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)boxNetSigalPillBoxDevice:(BleDataModel *)boxDeviceModel
                      andTimeout:(CGFloat)timeout
                     sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                    failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 药盒时钟校正
 @param ts 时间
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)checkTimePillBoxDevice:(BleDataModel *)boxDeviceModel
                          time:(long long)ts
                    andTimeout:(CGFloat)timeout
                   sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                  failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 药盒震动控制
 @param shakeStyle 震动方式，0：关闭震动， 1：开启震动，一直震动下去，2：500ms间隔震动，3：1000ms间隔震动
 @param totalTime 单位ms(毫秒)  开启震动后维持的总时长(shakeStyle==0时，此值为0)
 @param model  模式，表示 0:情景模式控制;1:指令模式控制
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)shakePillBoxDevice:(BleDataModel *)boxDeviceModel
                shakeStyle:(int)shakeStyle
                 totalTime:(int)totalTime
                     model:(int)model
                andTimeout:(CGFloat)timeout
               sucCallBack:(BoxSuccessResponseBlock)sucCallBack
              failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 药盒扬声器（语音）控制
 @param sountType 语音类型 ， 0：关闭正在播放的语音，其他语音类型由硬件按照序号1开始往后进行排列，告知我方开发人员即可,
 @param timeout 设定响应超时时间
 @param model  模式，表示 0:情景模式控制;1:指令模式控制
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)soundPillBoxDevice:(BleDataModel *)boxDeviceModel
                 sountType:(int)sountType
                     model:(int)model
                    volume:(int)volume
                andTimeout:(CGFloat)timeout
               sucCallBack:(BoxSuccessResponseBlock)sucCallBack
              failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 语音传输
 @param cell 该条业务数据 作用的仓号(数值)
 @param len 该条数据 控制后续二进制流的起始位置(默认为0)
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)willSpeechPillBoxDevice:(BleDataModel *)boxDeviceModel
                     andTimeout:(CGFloat)timeout
                           cell:(int)cell
                            len:(int)len
                    sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                   failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 文字阵列数据传输
 @param cell 该条业务数据 作用的仓号(数值)
 @param len 该条数据 控制后续二进制流的起始位置(默认为0)
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)fontTextPillBoxDevice:(BleDataModel *)boxDeviceModel
                   andTimeout:(CGFloat)timeout
                         cell:(int)cell
                          len:(int)len
                  sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                 failCallBack:(BoxFailureResponseBlock)failCallBack;

/// -----      业务方法 --------
/**
 补充药量 
 @param cell 该条业务数据 作用的仓号(数值)
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)fillMedicToPillBoxDevice:(BleDataModel *)boxDeviceModel
                      andTimeout:(CGFloat)timeout
                            cell:(int)cell
                     sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                    failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 监听药盒仓位状态（药盒主动通知）
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)notifyPostionStatePillBoxDevice:(BleDataModel *)boxDeviceModel
                             andTimeout:(CGFloat)timeout
                            sucCallBack:(void(^)(int pos,int coverState))sucCallBack
                           failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 移除监听药盒仓位状态（药盒主动通知
 */
- (void)removeNotifyPostionStatePillBoxDevice:(BleDataModel *)boxDeviceModel;
 


@end


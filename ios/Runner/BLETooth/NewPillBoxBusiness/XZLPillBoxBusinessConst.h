//
//  XZLPillBoxBusinessConst.h
//  XinZhiLi
//
//  Created by 董富强 on 2017/11/27.
//  Copyright © 2017年 xinzhili. All rights reserved.
//

#ifndef XZLPillBoxBusinessConst_h
#define XZLPillBoxBusinessConst_h
  
#import <CoreGraphics/CoreGraphics.h>

@class BleDataModel;
 
// 3代相关
extern NSString *const XZLThirdPillBoxBLEBusinessErrorDomain;

extern int const XZLThirdPillBoxBLEBusinessDefaultCode;

extern int const XZLThirdPillBoxBLEBusinessScanFailCode;

extern int const XZLThirdPillBoxBLEBusinessConnectCode;


// 包括2代3代所有药盒
extern NSString *const XZLAllPillBoxBLEBusinessErrorDomain;

extern int const XZLAllPillBoxBLEBusinessDefaultCode;

extern int const  XZLAllPillBoxBLEBusinessConnectFailCode;

extern int const  XZLAllPillBoxBLEBusinessBleOffCode;



//定义block回调
/** 成功回调Block */
typedef void (^BoxSuccessResponseBlock)(id responseObject);
/** 失败回调Block */
typedef void (^BoxFailureResponseBlock)(NSError *error);
/** 超时回调Block */
typedef void (^BoxTimeoutResponseBlock)(NSError *error);
 

#pragma mark - -> 协议制定
 
/**
 药盒相关业务性接口制定
 目的：指定药盒业务实现方需要实现哪些业务操作
 1.绑定 全MQTT：扫药盒二维码-药盒IMEI-
 2.解绑
 3.监测药盒连接状态（未连接、开始连接、连接中、连接成功、连接断开、其他）
 4.添加服药计划（同步添加API服务器数据和药盒存储数据），对操作结果可以进行回调
 5.删除服药计划（同步添加API服务器数据和药盒存储数据），对操作结果可以进行回调
 6.查询所有药盒的服药计划（并且可以根据排序规则进行排序后的数据返回）
 7.
 */
@protocol XZLPillBoxBusinessInterface

@optional;

/**
 登录用户的当前所有设备
 */
@property (nonatomic, assign, readonly) NSArray *allCurrentDevices;

 


/**
 建立当前所有药盒（有蓝牙功能的药盒）的蓝牙连接
 */
- (void)buildAllCurrentDevicesBLEConnection;


/**
 建立与 传入目标药盒（有蓝牙功能的药盒）的蓝牙连接
 */
- (void)buildDeviceBLEConnectionForTargetDevice:(BleDataModel *)targetDevice
                                        timeout:(CGFloat)timeout
                                    sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                                   failCallBack:(BoxFailureResponseBlock)failCallBack;

/**
 （通过蓝牙）启动药盒MQTT服务
 */
- (void)launchBoxMQTTService:(BleDataModel *)targetDevice
                 withTimeOut:(CGFloat)timeout
                 andCallBack:(void(^)(bool isSuc, NSError *error))callBack;


/**
 （通过蓝牙）关闭药盒MQTT服务(暂未实现)
 */
- (void)stopBoxMQTTServiceWithTimeOut:(CGFloat)timeout
                          andCallBack:(void(^)(void))callBack;


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
                failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 根据提供的药盒设备数据模型对其进行【解绑】操作
 
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)unbindOnePillBoxDevice:(BleDataModel *)boxDeviceModel
                    andTimeout:(CGFloat)timeout
                   sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                  failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 添加保存一组药盒的服药计划
 
 @param takePlanModels 服药计划数据模型列表
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)addSavePillBoxTakeMedicinePlans:(NSArray *)takePlanModels
                       forPillBoxDevice:(BleDataModel *)boxDeviceModel
                             andTimeout:(CGFloat)timeout
                            sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                           failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 编辑（修改）保存一组药盒的服药计划
 
 @param oldPlans 要清空和删除旧的服药计划数组（可以是id字符串数组或者BleDataModel实例数组）
 @param takePlanModels 新增的替换原来的服药计划模型数组
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)editeSavePillBoxWithOldPlans:(NSArray *)oldPlans
                newTakeMedicinePlans:(NSArray *)takePlanModels
                    forPillBoxDevice:(BleDataModel *)boxDeviceModel
                          andTimeout:(CGFloat)timeout
                         sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                        failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 删除一组药盒的服药计划
 
 @param takePlans 要清空和删除的服药计划（可以是id字符串数组或者BleDataModel实例数组）
 @param boxDeviceModel 药盒设备模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)removePillBoxTakeMedicinePlans:(NSArray *)takePlans
                      forPillBoxDevice:(BleDataModel *)boxDeviceModel
                            andTimeout:(CGFloat)timeout
                           sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                          failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 查询一个药盒设备里当前所有的服药计划
 
 @param boxDeviceModel 药盒设备数据模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)queryAllTakeMedicinePlansInPillBoxDevice:(BleDataModel *)boxDeviceModel
                                      andTimeout:(CGFloat)timeout
                                     sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                                    failCallBack:(BoxFailureResponseBlock)failCallBack;


/**
 比对当前时刻传入药盒实例所对应的药盒内部存储的服药计划和当前APP（后端）存储的服药计划，并且做diff运算，回调运算结果

 @param boxDeviceModel 药盒设备数据模型
 @param timeout 设定响应超时时间
 @param sucCallBack 完成调用完全成功后回调（返回一个相关业务的实例对象）
 @param failCallBack 没有完成执行的调用，失败回调（只携带错误原因字符串表示说明）
 */
- (void)diffBoxAndAppMedicinePlans:(BleDataModel *)boxDeviceModel
                        andTimeout:(CGFloat)timeout
                       sucCallBack:(BoxSuccessResponseBlock)sucCallBack
                      failCallBack:(BoxFailureResponseBlock)failCallBack;


@end



#pragma mark - --> 2、药盒功能处理接口

/**
 药盒相关功能性接口制定
 目的：指定药盒功能实现方实现的药盒哪些功能操作
 */
@protocol XZLPillBoxFunctionInterface

@optional;

//1.获取药盒电量

//2.获取药盒地理位置

//3.校正药盒时钟

//4.药盒功能灯的控制
- (void)controlLightForPillBox:(BleDataModel *)targetDevice
                       postion:(int)pNo
                     lightType:(int)lightType
                    flashStyle:(int)style
                       timeout:(CGFloat)timeout
                      callBack:(void(^)(bool ,NSError *))callBack;

//5.药盒声音播报的控制
- (void)controlVoiceForPillBox:(BleDataModel *)targetDevice
                     soundType:(int)soundType
                      callBack:(void(^)(bool ,NSError *))callBack;

//6.指示药盒开始进行填药操作
- (void)controlFillMedicineForPillBox:(BleDataModel *)targetDevice
                              postion:(NSArray *)pNos
                             callBack:(void(^)(bool ,NSError *))callBack;

//7.指示药盒进行填药的联合组合操作
- (void)controlUnionFillMedicineForPillBox:(BleDataModel *)targetDevice
                                   postion:(NSArray *)pNos
                                  callBack:(void(^)(bool ,NSError *))callBack;
@end


#pragma mark - --> 3、对用户的所有药盒管理接口

/**
 药盒业务实现方 需要实现对药盒进行管理的接口
 目的：指定与药盒通信交互的数据结构歇息
 */
@protocol XZLPillBoxBusinessManagerInterface

@optional;

/**
 返回当前用户所有已经绑定的药盒
 
 @return 药盒实例数组
 */
- (NSArray *)allCurrentPillBoxes;

/**
 为用户添加一个药盒 对其进行管理
 */
- (bool)addPillBox:(BleDataModel *)boxDevice;

/**
 为用户删除一个药盒 不再对其进行管理
 */
- (bool)removePillBox:(BleDataModel *)boxDevice;

/**
 清空所有药盒
 */
- (void)removeAllPillBoxes;


@end





/**
 药盒实例 需要实现能力接口
 */
@protocol XZLPillBoxCapacityInterface 

/** 蓝牙相关操作和数据管理类 */

@end


 
 
#endif /* XZLPillBoxBusinessConst_h */






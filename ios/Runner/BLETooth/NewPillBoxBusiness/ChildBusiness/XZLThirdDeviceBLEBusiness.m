//
//  XZLThirdDeviceBLEBusiness.m
//  XinZhiLi
//
//  Created by suhua zhou on 2019/3/8.
//  Copyright © 2019 xinzhili. All rights reserved.
//

#import "XZLThirdDeviceBLEBusiness.h"
#import "BleDataModel.h"
#import "NewBleManager.h"

@interface XZLThirdDeviceBLEBusiness()

@property (nonatomic, strong) Device *device;

@end

@implementation XZLThirdDeviceBLEBusiness

- (void)disconnectTargetDevice:(BleDataModel *)targetDevice {
    
    __block NewBleTask *getDeviceTask =  [NewBleManager getDevice:targetDevice.mac ofType:DT_ThreePillBox completeHandler:^(NewBleResult * _Nonnull result, __kindof Device * _Nullable device) {
        
        if (device) {
            
            __block NewBleTask *connectTask = [device getDisconnectTaskWithCompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    
                } else {
                    
                }
                connectTask = nil;
            }];
            [connectTask async];
            
        } else {
            
        }
        getDeviceTask = nil;
    }];
    [getDeviceTask async];
}

// 一、药盒电源和电量
- (void)getBatteryPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
         
        if (device) {
            
            NewBleTask *bindTask = [device getDeviceBatteryTaskWithCompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(boxDeviceModel);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            bindTask.timeout = timeout;
            [bindTask async];
        }
    } failCallBack:^(NSError *error) {
        
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 四、绑定和解绑  绑定
- (void)bindOnePillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    DDLogInfo(@"zhousuhua ---- bindOnePillBoxDevice: ---- ");
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
         
        if (device) {
             
            NewBleTask *bindTask = [device getBindDeviceTaskWithDeviceModel:boxDeviceModel CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(boxDeviceModel);
                    }
                    // 绑定成功后发送个人信息
//                    [self personInfoPillBoxDevice:boxDeviceModel andTimeout:90 sucCallBack:sucCallBack failCallBack:failCallBack];
                } else {
                    
                    if ([result.message isEqualToString:@"Binded already"]) { // 如果是已绑定，先执行解绑再绑定
                        
                        [self unbindOnePillBoxDevice:boxDeviceModel andTimeout:timeout sucCallBack:^(id responseObject) {
                            
                            [self bindOnePillBoxDevice:boxDeviceModel andTimeout:timeout sucCallBack:sucCallBack failCallBack:failCallBack];
                        } failCallBack:^(NSError *error) {
                            
                            if (failCallBack) {
                                failCallBack(error);
                            }
                        }];
                        
                    } else {
                        
                        NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                            code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                        userInfo:@{NSLocalizedDescriptionKey:result.message}];
                        
                        if (failCallBack) {
                            failCallBack(error);
                        }
                    }
                }
            }];
            bindTask.timeout = timeout;
            [bindTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 四、绑定和解绑  解绑
- (void)unbindOnePillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    DDLogInfo(@"解绑 ---- unbindOnePillBoxDevice: ---- ");
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
    
        if (device) {
            
            NewBleTask *unBindTask = [device getDisBindDeviceTaskWithboxDeviceModel:boxDeviceModel CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                DDLogInfo(@"解绑 ---- result.code:%ld success:%d ---- ",(long)result.code,result.code == NBRC_Ok);
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(boxDeviceModel);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            unBindTask.timeout = timeout;
            [unBindTask async];
        }  
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

- (void)personInfoPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    
}

// 五、医嘱操作(服药计划) 添加医嘱数据操作
- (void)addSavePillBoxTakeMedicinePlans:(NSArray<BleDataModel *> *)takePlanModels forPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    __weak typeof(self) weakSelf = self;
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *addPlansTask = [device getAddPlanTaskWithPlan:takePlanModels CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                    BleDataModel *info = [takePlanModels firstObject];
                    [weakSelf sendVoiceLattice:info pillBoxDevice:boxDeviceModel sucCallBack:sucCallBack failCallBack:failCallBack];
                    
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            addPlansTask.timeout = timeout;
            [addPlansTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

- (void)sendVoiceLattice:(BleDataModel *)info pillBoxDevice:(BleDataModel *)boxDeviceModel sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack  {
    
}

- (void)voiceLatticeSendPillBoxDevice:(BleDataModel *)boxDeviceModel data:(NSData *)data dataType:(DataType)type postion:(NSString *)postion andTimeout:(CGFloat)timeout times:(int)times sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
}

- (void)voiceLatticeSendPillBoxDevice:(BleDataModel *)boxDeviceModel data:(NSData *)data dataType:(DataType)type postion:(NSString *)postion andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
}

- (void)sendDataAfter:(int)time sucCallBack:(void(^)(void))BoxSuccessResponseBlock failCallBack:(void(^)(void))BoxFailResponseBlock {
    
    if (time == 0) {
        BoxFailResponseBlock();
        return;
    }
    DDLogDebug(@"zhouzhou --- sendDataAftersendDataAftersendDataAftersendDataAfter---%ld curr:%@",(long)time,[NSThread currentThread]);
    [self sendDataAfter:time-1 sucCallBack:BoxSuccessResponseBlock failCallBack:BoxFailResponseBlock];
}

// 五、医嘱操作(服药计划) 删除医嘱数据操作
- (void)removePillBoxTakeMedicinePlans:(NSArray<BleDataModel *> *)takePlans forPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *removePlanTask = [device deletePlanTaskWithPlan:takePlans CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                     
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            removePlanTask.timeout = timeout;
            [removePlanTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 五、医嘱操作(服药计划) 修改医嘱数据操作 (删除之前的医嘱数据，新增新医嘱数据)
- (void)editeSavePillBoxWithOldPlans:(NSArray<BleDataModel *> *)oldPlans newTakeMedicinePlans:(NSArray<BleDataModel *> *)takePlanModels forPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
}

// 五、医嘱操作(服药计划) 获取医嘱数据操作
- (void)queryAllTakeMedicinePlansInPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
}


// 六、服药提醒
- (void)medicationReminderPillBoxDevice:(BleDataModel *)boxDeviceModel delayPlans:(NSArray<BleDataModel *> *)delayPlans andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *medicReminderTask = [device getMedicationReminderWithDelayPlans:delayPlans CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            medicReminderTask.timeout = timeout;
            [medicReminderTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 七、填药操作指示
- (void)controlFillMedicineForPillBox:(BleDataModel *)targetDevice postion:(NSArray *)pNos callBack:(void (^)(bool, NSError *))callBack {
    
    [self getConnectDevice:targetDevice timeout:-1 sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *editPlanTask = [device getFillMedicTask:pNos CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (callBack) {
                        callBack(YES,nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    if (callBack) {
                        callBack(NO,error);
                    }
                }
            }];
            editPlanTask.timeout = 90;
            [editPlanTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (callBack) {
            callBack(NO,error);
        }
    }];
}

- (void)controlUnionFillMedicineForPillBox:(BleDataModel *)targetDevice
                                   postion:(NSArray *)pNos
                                  callBack:(void(^)(bool ,NSError *))callBack {
    
    [self controlFillMedicineForPillBox:targetDevice postion:pNos callBack:callBack];
}

// 八、药盒仓位状态
- (void)postionStateCommandPillBoxDevice:(BleDataModel *)boxDeviceModel postions:(NSArray *)postions andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *getPostionTask = [device getPostionStateCommandWithPostions:postions CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            getPostionTask.timeout = timeout;
            [getPostionTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 九、药盒药量感知
- (void)cellWeightCommandPillBoxDevice:(BleDataModel *)boxDeviceModel postions:(NSArray *)postions andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *getPostionTask = [device getCellWeightCommandWithPostions:postions CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            getPostionTask.timeout = timeout;
            [getPostionTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十、药盒正反（放置）状态
- (void)boxStateCommandPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *getBoxStateTask = [device getBoxStateCommandCompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            getBoxStateTask.timeout = timeout;
            [getBoxStateTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十一、药盒地理位置
- (void)boxLoactionPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *getBoxLoactionTask = [device getBoxLoactionCompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            getBoxLoactionTask.timeout = timeout;
            [getBoxLoactionTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十二、药盒运营商网络信号强度
- (void)boxNetSigalPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *boxNetSigalTask = [device getBoxNetSigalCompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            boxNetSigalTask.timeout = timeout;
            [boxNetSigalTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十三、药盒时钟校正
- (void)checkTimePillBoxDevice:(BleDataModel *)boxDeviceModel time:(long long)ts andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *checkTimeTask = [device getCheckTimeWithTime:ts CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            checkTimeTask.timeout = timeout;
            [checkTimeTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十四、药盒震动控制
- (void)shakePillBoxDevice:(BleDataModel *)boxDeviceModel shakeStyle:(int)shakeStyle totalTime:(int)totalTime model:(int)model andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *shakeTask = [device getShakeWithShakeStyle:shakeStyle totalTime:totalTime model:model CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            shakeTask.timeout = timeout;
            [shakeTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十五、药盒扬声器（语音）控制

- (void)soundPillBoxDevice:(BleDataModel *)boxDeviceModel
                 sountType:(int)sountType
                     model:(int)model
                    volume:(int)volume
                andTimeout:(CGFloat)timeout
               sucCallBack:(BoxSuccessResponseBlock)sucCallBack
              failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *soundTask = [device getSoundWithSountType:sountType model:(int)model volume:volume CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            soundTask.timeout = timeout;
            [soundTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

// 十六、药盒功能灯控制
- (void)controlLightForPillBox:(BleDataModel *)targetDevice postion:(int)pNo lightType:(int)lightType flashStyle:(int)style timeout:(CGFloat)timeout callBack:(void (^)(bool, NSError *))callBack {
    
    
    [self getConnectDevice:targetDevice timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *editPlanTask = [device getLightControlTask:lightType flashStyle:style totalTime:timeout CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (callBack) {
                        callBack(YES,nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (callBack) {
                        callBack(NO,error);
                    }
                }
            }];
            editPlanTask.timeout = timeout;
            [editPlanTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (callBack) {
            callBack(NO,error);
        }
    }];
}


- (void)willSpeechPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout cell:(int)cell len:(int)len sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *willSpeechTask = [device getWillSpeechWithCell:cell len:len CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            willSpeechTask.timeout = timeout;
            [willSpeechTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

- (void)fontTextPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout cell:(int)cell len:(int)len sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        
        DDLogDebug(@"sucCallBack device:%@",device);
        if (device) {
            
            NewBleTask *fontTextTask = [device getFontTextWithCell:cell len:len CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            fontTextTask.timeout = timeout;
            [fontTextTask async];
        }
    } failCallBack:failCallBack];
}


- (void)buildDeviceBLEConnectionForTargetDevice:(BleDataModel *)targetDevice timeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    [self getConnectDevice:targetDevice timeout:timeout sucCallBack:sucCallBack failCallBack:failCallBack];
}

- (void)notifyPostionStatePillBoxDevice:(BleDataModel *)boxDeviceModel
                             andTimeout:(CGFloat)timeout
                            sucCallBack:(void(^)(int pos,int coverState))sucCallBack
                           failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    
    
}

- (void)removeNotifyPostionStatePillBoxDevice:(BleDataModel *)boxDeviceModel {
    
    [_device removeNotifyPostionStateCommand];
}


#pragma mark ---- 私有方法 -------
// 发蓝牙指令之前都会调用这个方法，所以在这里判断是否有正在发送中的数据，有则不让继续发送
- (void)getConnectDevice:(BleDataModel *)boxDeviceModel timeout:(CGFloat)timeout sucCallBack:(void(^)(Device *))sucCallBack failCallBack:(void(^)(NSError *))failCallBack {
    
    if (_isSendDatas) {

        NSError *err = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                           code:XZLThirdPillBoxBLEBusinessDefaultCode
                                       userInfo:@{NSLocalizedDescriptionKey:@"正在发送数据，请稍后再试"}];

        if (failCallBack) {
            failCallBack(err);
        }
        return;
    }

    NSRange macRange = NSMakeRange(4, 8);
    NSString *spiltMac = [[boxDeviceModel.mac componentsSeparatedByString:@":"] componentsJoinedByString:@""];
    NSString *deviceName = [NSString stringWithFormat:@"MBox%@",[spiltMac substringWithRange:macRange]];
    
//    NSString *deviceName = [NSString stringWithFormat:@"MBox090AB45A"];
    // 190A1D56
   __block NewBleTask *getDeviceTask =  [NewBleManager getDevice:deviceName ofType:DT_ThreePillBox completeHandler:^(NewBleResult * _Nonnull result, __kindof Device * _Nullable device) {
        
        if (device) {
            
            self->_device = device;
            device.boxDeviceModel = boxDeviceModel;
           __block NewBleTask *connectTask = [device getConnectTaskWithCompleteHandler:^(NewBleResult * _Nonnull result) {

                if (result.code == NBRC_Ok) {

                    if (sucCallBack) {
                        sucCallBack(device);
                    }

                } else {

                    NSError *err = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                       code:XZLThirdPillBoxBLEBusinessConnectCode
                                                   userInfo:@{NSLocalizedDescriptionKey:@"连接失败"}];

                    if (failCallBack) {
                        failCallBack(err);
                    }
                }
               connectTask = nil;
            }];
            connectTask.timeout = timeout;
            [connectTask async];
            
        } else {
            
            NSError *err = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                               code:XZLThirdPillBoxBLEBusinessScanFailCode
                                           userInfo:@{NSLocalizedDescriptionKey:@"未扫描到指定设备"}];
            
            if (failCallBack) {
              
                failCallBack(err);
            }
        }
       getDeviceTask = nil;
    }];
    getDeviceTask.timeout = timeout;
    [getDeviceTask async];
}

- (void)removeDeviceFormDeviceList:(BleDataModel *)targetDevice {
    
    NSRange macRange = NSMakeRange(4, 8);
    NSString *spiltMac = [[targetDevice.mac componentsSeparatedByString:@":"] componentsJoinedByString:@""];
    NSString *deviceName = [NSString stringWithFormat:@"MBox%@",[spiltMac substringWithRange:macRange]];
   [NewBleManager removeDevice:deviceName completeHandler:nil];
}

- (void)privateEditeSavePillBoxWithOldPlans:(NSArray<BleDataModel *> *)oldPlans newTakeMedicinePlans:(NSArray<BleDataModel *> *)takePlanModels forPillBoxDevice:(BleDataModel *)boxDeviceModel andTimeout:(CGFloat)timeout sucCallBack:(BoxSuccessResponseBlock)sucCallBack failCallBack:(BoxFailureResponseBlock)failCallBack {
    
    BleDataModel *oldMetaInfo = [oldPlans firstObject];
    BleDataModel *newMetaInfo = [takePlanModels firstObject];
    NSArray *oldPos;
    if (![oldMetaInfo.positionNo isEqualToString:newMetaInfo.positionNo]) {
        
        oldPos = @[@([oldMetaInfo.positionNo integerValue])];
    }
    
    [self getConnectDevice:boxDeviceModel timeout:timeout sucCallBack:^(Device *device) {
        
        if (device) {
            
            NewBleTask *editPlanTask = [device editPlanTaskWithPlan:oldPlans newPlan:takePlanModels oldPos:oldPos CompleteHandler:^(NewBleResult * _Nonnull result) {
                
                if (result.code == NBRC_Ok) {
                    
                    if (sucCallBack) {
                        sucCallBack(nil);
                    }
                } else {
                    
                    NSError *error = [NSError errorWithDomain:XZLThirdPillBoxBLEBusinessErrorDomain
                                                         code:XZLThirdPillBoxBLEBusinessDefaultCode
                                                     userInfo:@{NSLocalizedDescriptionKey:result.message}];
                    
                    if (failCallBack) {
                        failCallBack(error);
                    }
                }
            }];
            editPlanTask.timeout = timeout;
            [editPlanTask async];
        }
    } failCallBack:^(NSError *error) {
        
        if (failCallBack) {
            failCallBack(error);
        }
    }];
}

@end

//
//  CommandParser.m
//  XinZhiLi
//
//  Created by suhua zhou on 2018/12/20.
//  Copyright © 2018 xinzhili. All rights reserved.
//

#import "CommandParser.h"
#import "BT_PostionStateTask.h"
#import "XZLNewPillBoxMessage.h"
#import "ThirdCommandSender.h"
//#import "XZLAllPillBoxBusiness.h"

#import "BT_FillMedicTask.h"
#import "MJExtension.h"
//#import "XZLPillBoxBusiness+NetBus.h"

@implementation CommandParser

+ (CommandParser *)sharedInstance {
    static CommandParser *_parser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [[CommandParser alloc] init];
    });
    
    return _parser;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _taskDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)appendTask:(NewBleTask *)task taskId:(ActionID)taskId {
    
    NSString *taskIdKey = [NSString stringWithFormat:@"%d",taskId];
    NewBleTask *oldTask = [_taskDic objectForKey:taskIdKey];
    
    if (oldTask) {
        [oldTask cancel];
        oldTask = nil;
    }
    [_taskDic setObject:task forKey:taskIdKey];
}

- (void)removeTaskId:(ActionID)taskId {
    
    NSString *taskIdKey = [NSString stringWithFormat:@"%d",taskId];
    NewBleTask *oldTask = [_taskDic objectForKey:taskIdKey];
    
    if (oldTask) {
        [oldTask cancel];
        oldTask = nil;
    }
    [_taskDic removeObjectForKey:taskIdKey];
}

- (void)removeTask:(NewBleTask *)task {
    
    for (NSString *key in _taskDic.allKeys) {
        
        NewBleTask *obj = [_taskDic objectForKey:key];
        if ([obj isEqual:task]) {
             
            [self->_taskDic removeObjectForKey:key];
        }
    }
}

// 3代药盒用的解析
- (void)handleNewBLEResultBusinessData:(NSData *)businessData storeId:(NSInteger)storeId {
//
    if (businessData == nil) { // 语音铃声没有简单响应，所以发送成功就会走这个方法

//        NSArray *actionId = @[@(ShakeAction),@(SoundAction)];
//        for (int i = 0; i < actionId.count; i++) {
//
//            NewBleTask *task = [_taskDic objectForKey:[NSString stringWithFormat:@"%ld",[actionId[i] intValue]]];
//            if (task) {
//                task.result.code = NBRC_Ok;
//                [task finish];
//                [_taskDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)storeId]];
//            }
//        }
        return;
    }
//
    NSDictionary *dic = [self dictionaryWithbusinessData:businessData];

    XZLNewPillBoxResponSimpleMessage *responMessage = [XZLNewPillBoxResponSimpleMessage mj_objectWithKeyValues:dic];

    NSString *taskIdKey = [NSString stringWithFormat:@"%ld",(long)responMessage.action];
    NewBleTask *task = [_taskDic objectForKey:taskIdKey];

    if (responMessage.action == RespCellState) {

        taskIdKey =[NSString stringWithFormat:@"%d",PositionStateAction];
        task = [_taskDic objectForKey:taskIdKey];
        responMessage = [XZLNewPillBoxResponPostionStateMessage mj_objectWithKeyValues:dic];
        responMessage.state == RespSimpleSuccess;

    } else if (responMessage.action == NotifyCellState) {

        task = [_taskDic objectForKey:taskIdKey];
        responMessage = [XZLNewPillBoxNotifyPostionStateMessage mj_objectWithKeyValues:dic];
//        responMessage.state == RespSimpleSuccess;
//        XZLNewPillBoxState *state = [((XZLNewPillBoxResponPostionStateMessage *)responMessage).stateList lastObject];
        ((BT_PostionStateTask *)task).coverState = ((XZLNewPillBoxNotifyPostionStateMessage *)responMessage).cellCover;
        ((BT_PostionStateTask *)task).pos = ((XZLNewPillBoxNotifyPostionStateMessage *)responMessage).position;
    } else if (responMessage.action == CellWeightAction) {

        taskIdKey =[NSString stringWithFormat:@"%d",RespCellWeight];
        task = [_taskDic objectForKey:taskIdKey];
        responMessage = [XZLNewPillBoxResponCellWeightMessage mj_objectWithKeyValues:dic];
    } else if (responMessage.action == RespBoxState) {

        taskIdKey =[NSString stringWithFormat:@"%d",BoxStateAction];
        task = [_taskDic objectForKey:taskIdKey];
        responMessage = [XZLNewPillBoxResponBoxStateMessage mj_objectWithKeyValues:dic];
    } else if (responMessage.action == RespNowBattery) {

        taskIdKey =[NSString stringWithFormat:@"%d",GetNowBattery];
        task = [_taskDic objectForKey:taskIdKey];
        responMessage = [XZLNewPillBoxResponBatteryMessage mj_objectWithKeyValues:dic];
        responMessage.state == RespSimpleSuccess;
    } else if (responMessage.action == DeletePlanAction) { // 删除的成功响应

        if (responMessage.state == RespSimpleSuccess || (responMessage.state == RespSimpleFail && [responMessage._description isEqualToString:@"planId Error!"])) {

            taskIdKey =[NSString stringWithFormat:@"%d",DeletePlanAction];
            task = [_taskDic objectForKey:taskIdKey];
            responMessage = [XZLNewPillBoxResponDeletePlan mj_objectWithKeyValues:dic];
            responMessage.state = RespSimpleSuccess;
        }
    } else if (responMessage.action == UnBindDeviceAction) { // 解绑的响应

        if (responMessage.state == RespSimpleFail) {

            if ([responMessage._description isEqualToString:@"Not bind"]) {

                responMessage.state = RespSimpleSuccess;
            }
        }
    }

    if ([responMessage respondsToSelector:@selector(state)]) {
        if (responMessage.state == RespSimpleSuccess) { // 成功

            task.result.code = NBRC_Ok;
        } else {

            task.result.code = NBRC_Error;
            if ([responMessage._description isEqualToString:@"dataExceed"]) {

                responMessage._description = @"数据异常，请退出当前页面后重试";
            } else if ([responMessage._description isEqualToString:@"inEating"]) {
                responMessage._description = @"药盒操作中，请完成操作后重试";
            }
            task.result.message = responMessage._description;
        }
    } else {

        task.result.code = NBRC_Ok;
    }

    task.result.resopnMessage = responMessage;
    [task finish];
    if ((responMessage.action != NotifyCellState)) {

        [_taskDic removeObjectForKey:taskIdKey];
    }
//
    if (responMessage.action == NotifyCellState || responMessage.action == NotifyFullBattery || responMessage.action == NOtifyGradBattery || responMessage.action == NOtifyInBattery || responMessage.action == NOtifyOutBattery || responMessage.action == NotifyBoxState) {


    } else {

        [self.iOSSdk stopSendData];  // 如果收到了简单响应说明可以继续发送新的数据了，由于sdk的发送完成会比药盒响应慢0.5秒左右，所以收到药盒响应后要想继续用sdk发送数据需要调用一下stopSendData将sdk状态改为可以发送新数据
//        [XZLPillBoxDefuaultBusiness thirdDeviceSendDatas:NO];
    }
    
}

- (NSDictionary*)dictionaryWithbusinessData:(NSData*)businessData {
    
    if(businessData ==nil) {
        return nil;
    }
    
    NSError*err;
    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:businessData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        
        DDLogDebug(@"json解析失败：%@",err);
        return nil;
    }
    
    NSMutableDictionary*newdict=[[NSMutableDictionary alloc]init];
    
    for(NSString*keys in dic) {
        
        if(dic[keys]==[NSNull null]) {
            
            [newdict setObject:@" "forKey:keys];
            continue;
        }
        [newdict setObject:[NSString stringWithFormat:@"%@",dic[keys]]forKey:keys];
    }
    return newdict;
}

- (void)sendFailTaskFlat:(char)taskFlag errorDes:(NSString *)errorDes {
    
    if (errorDes.length == 0) {
        errorDes = @"药盒发送超时";
    }
    if (taskFlag == BleSdkTaskIdUnKnow) {
        [self sendFailTaskFlat:BleSdkTaskIdJSON errorDes:errorDes];
        [self sendFailTaskFlat:BleSdkTaskIdVoice errorDes:errorDes];
        [self sendFailTaskFlat:BleSdkTaskIdPixels errorDes:errorDes];
        [self sendFailTaskFlat:BleSdkTaskIdPersonal errorDes:errorDes];
    } else if (taskFlag == BleSdkTaskIdJSON) {
        
        for (NSString *key in _taskDic.allKeys) {
            
            NewBleTask *obj = [_taskDic objectForKey:key];
            if (obj) {
                [(NewBleTask *)obj error:errorDes];
            }
            [self->_taskDic removeObjectForKey:key];
        }
    } else if (taskFlag == BleSdkTaskIdVoice) {
        
        NewBleTask *task = [_taskDic objectForKey:[NSString stringWithFormat:@"%d",WillSpeeh]];
        [task error:errorDes];
        [_taskDic removeObjectForKey:[NSString stringWithFormat:@"%d",WillSpeeh]];
    } else if (taskFlag == BleSdkTaskIdPixels) {
        
        NewBleTask *task = [_taskDic objectForKey:[NSString stringWithFormat:@"%d",FontText]];
        [task error:errorDes];
        [_taskDic removeObjectForKey:[NSString stringWithFormat:@"%d",FontText]];
    } else if (taskFlag == BleSdkTaskIdPersonal) {
        
        NewBleTask *fontTask = [_taskDic objectForKey:[NSString stringWithFormat:@"%d",RespPersonFont]];
        [fontTask error:errorDes];
        [_taskDic removeObjectForKey:[NSString stringWithFormat:@"%d",RespPersonFont]];
        
        NewBleTask *voiceTask = [_taskDic objectForKey:[NSString stringWithFormat:@"%d",RespPersonVoice]];
        [voiceTask error:errorDes];
        [_taskDic removeObjectForKey:[NSString stringWithFormat:@"%d",RespPersonVoice]];
    }
}




@end

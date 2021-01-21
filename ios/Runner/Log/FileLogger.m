//
//  FileLogger.m
//  xzldoctor
//
//  Created by 周素华 on 23/4/2020.
//  Copyright © 2020 doctor. All rights reserved.
//

#import "FileLogger.h"

@implementation FileLogger

+(instancetype)sharedInstance
{
    static FileLogger *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[FileLogger alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    DDLogFileManagerDefault *defaultLogFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[FileLogger getLogPath]];
    defaultLogFileManager.maximumNumberOfLogFiles = 50;
    self = [super initWithLogFileManager:defaultLogFileManager];
    if (self) {
        self.rollingFrequency = 24 * 60 * 60;
    }
    
    return self;
}


- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    /*
     *格式如下：
     *  日期 时间 (文件名:行号) [队列名:线程号] 消息内容
     */
    
    NSDate *date = [logMessage timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    //    NSString *QueueName = [logMessage threadName];
    NSString *QueueLabel = [logMessage queueLabel];
    NSString *TID = [logMessage threadID];
    NSString *fileName = [logMessage fileName];
    NSString *function = [logMessage function];
    NSUInteger line = [logMessage line];
    
    return [[NSString alloc] initWithFormat:@"%@ (%@:%@%lu) [%@:%@] %@", strDate, fileName, function,(unsigned long)line, QueueLabel, TID, [logMessage message]];
}

+ (NSString *)getLogPath{
    
    NSString *folder = @"/Documents/Log";
    NSString *path = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), folder];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

@end

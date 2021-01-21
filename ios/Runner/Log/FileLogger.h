//
//  FileLogger.h
//  xzldoctor
//
//  Created by 周素华 on 23/4/2020.
//  Copyright © 2020 doctor. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
 

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelAll;
#endif

NS_ASSUME_NONNULL_BEGIN

@interface FileLogger : DDFileLogger <DDLogFormatter>

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END

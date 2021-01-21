//
//  LogManager.m
//  xzldoctor
//
//  Created by 周素华 on 23/4/2020.
//  Copyright © 2020 doctor. All rights reserved.
//

#import "LogManager.h"
#import "FileLogger.h"




@implementation LogManager

+ (void)initLogger
{
    [[DDTTYLogger sharedInstance] setLogFormatter:[FileLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    BOOL isShowDebug = true;
    NSString *bundleIDString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([bundleIDString containsString:@"development"]) {
        isShowDebug = NO;
    } else if([bundleIDString containsString:@"test"]) {
        isShowDebug = NO;
    }
     
    if (isShowDebug) {
        #ifdef DEBUG
            [[FileLogger sharedInstance] setLogFormatter:[FileLogger sharedInstance]];
            [DDLog addLogger:[FileLogger sharedInstance]];
        #endif
    } else {
        
        [[FileLogger sharedInstance] setLogFormatter:[FileLogger sharedInstance]];
        [DDLog addLogger:[FileLogger sharedInstance]];
    }

    
    DDLogDebug(@"*********************************************");
    DDLogDebug(@"*          Hello world                      *");
    DDLogError(@"*                         ++by Logger   *");
    DDLogError(@"*********************************************");
}

@end

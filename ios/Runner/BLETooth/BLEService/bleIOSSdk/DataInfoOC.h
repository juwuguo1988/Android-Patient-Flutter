//
//  DataInfoOC.h
//  bleIOSSdk
//
//  Created by 董海伟 on 2019/2/24.
//  Copyright © 2019 董海伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataInfoOC : NSObject
@property (assign, nonatomic) int       dataLen;
@property (assign, nonatomic) char      taskId;
@property (assign, nonatomic) char      storeId;
@end

NS_ASSUME_NONNULL_END

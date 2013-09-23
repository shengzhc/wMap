//
//  WMLocalNotificationManager.h
//  wMap
//
//  Created by Shengzhe Chen on 9/19/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMShowEntity.h"

@interface WMLocalNotificationManager : NSObject

+ (void)scheduleLocalNotificationWithShowEntity:(WMShowEntity *)showEntity;


@end

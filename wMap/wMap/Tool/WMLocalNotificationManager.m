//
//  WMLocalNotificationManager.m
//  wMap
//
//  Created by Shengzhe Chen on 9/19/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMLocalNotificationManager.h"

@implementation WMLocalNotificationManager

+ (void)scheduleLocalNotificationWithShowEntity:(WMShowEntity *)showEntity
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [showEntity.date dateByAddingTimeInterval:-(10*60)];
    notification.alertBody = [NSString stringWithFormat:@"%@", showEntity.name];
    notification.userInfo = @{@"sid": [showEntity uniqueIdentifier]};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

+ (void)removeLocalNotificationWithShowEntity:(WMShowEntity *)showEntity
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notification in notifications)
    {
        if ([[notification.userInfo valueForKey:@"sid"] isEqualToString:[showEntity uniqueIdentifier]])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            break;
        }
    }
}

@end

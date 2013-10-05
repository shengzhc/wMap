//
//  WMShowEntity.m
//  wMap
//
//  Created by Shengzhe Chen on 9/21/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowEntity.h"

@implementation WMShowEntity

+ (WMShowEntity *)entityWithDictionary:(NSDictionary *)dictionary
{
    WMShowEntity *showEntity = [[WMShowEntity alloc] init];
    showEntity.name = [dictionary valueForKey:@"name"];
    showEntity.address = [dictionary valueForKey:@"address"];
    showEntity.description = [dictionary valueForKey:@"description"];
    showEntity.image = [dictionary valueForKey:@"image"];
    showEntity.latitude = [dictionary valueForKeyPath:@"coordination.latitude"];
    showEntity.longitude = [dictionary valueForKeyPath:@"coordination.longitude"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    showEntity.date = [formatter dateFromString:[dictionary valueForKeyPath:@"time"]];
    return showEntity;
}

- (NSString *)uniqueIdentifier
{
    return [NSString stringWithFormat:@"%@_%@", self.name, self.address];
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
}

- (NSString *)title
{
    return self.address;
}

- (NSString *)subtitle
{
    return self.name;
}

@end

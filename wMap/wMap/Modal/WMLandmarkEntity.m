//
//  WMLandmarkEntity.m
//  wMap
//
//  Created by Shengzhe Chen on 9/21/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMLandmarkEntity.h"

@implementation WMLandmarkEntity

+ (WMLandmarkEntity *)entityWithDictionary:(NSDictionary *)dictionary
{
    WMLandmarkEntity *landmark = [[WMLandmarkEntity alloc] init];
    landmark.name = [dictionary valueForKey:@"name"];
    landmark.nickname = [dictionary valueForKey:@"nickName"];
    landmark.desc = [dictionary valueForKeyPath:@"description.history"];
    landmark.image = [dictionary valueForKey:@"image"];
    landmark.latitude = [dictionary valueForKeyPath:@"coordination.latitude"];
    landmark.longitude = [dictionary valueForKeyPath:@"coordination.longitude"];
    return landmark;
}

- (NSString *)uniqueIdentifier
{
    return [NSString stringWithFormat:@"landmark-%@", self.name];
}


@end

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
    return showEntity;
}

- (NSString *)uniqueIdentifier
{
    return [NSString stringWithFormat:@"%@_%@", self.name, self.address];
}

@end

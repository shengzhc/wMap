//
//  WMAMapPOI.m
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMAMapPOI.h"

@implementation WMAMapPOI

+ (WMAMapPOI *)entityWithAMapPOI:(AMapPOI *)poi
{
    WMAMapPOI *wPoi = [[WMAMapPOI alloc] init];
    wPoi.poi = poi;
    
    return wPoi;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[WMAMapPOI class]] && [((WMAMapPOI *)object).poi.uid isEqualToString:self.poi.uid])
    {
        return YES;
    }
    
    return NO;
}

- (NSString *)uniqueKey
{
    return self.poi.uid;
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.poi.location.latitude, self.poi.location.longitude);
}

- (NSString *)title
{
    return self.poi.name;
}

- (NSString *)subtitle
{
    return self.poi.address;
}

@end

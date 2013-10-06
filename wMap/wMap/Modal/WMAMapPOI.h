//
//  WMAMapPOI.h
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <AMapSearchKit/AMapSearchAPI.h>

@interface WMAMapPOI : NSObject < MAAnnotation >

@property (nonatomic, strong) AMapPOI *poi;

+ (WMAMapPOI *)entityWithAMapPOI:(AMapPOI *)poi;

@end


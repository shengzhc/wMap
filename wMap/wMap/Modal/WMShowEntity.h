//
//  WMShowEntity.h
//  wMap
//
//  Created by Shengzhe Chen on 9/21/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface WMShowEntity : NSObject < MAAnnotation >

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSDate *date;

+ (WMShowEntity *)entityWithDictionary:(NSDictionary *)dictionary;
- (NSString *)uniqueIdentifier;

@end

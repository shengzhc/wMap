//
//  WMLandmarkEntity.h
//  wMap
//
//  Created by Shengzhe Chen on 9/21/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMLandmarkEntity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *image;

@end

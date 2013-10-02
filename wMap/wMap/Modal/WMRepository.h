//
//  WMRepository.h
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMLandmarkEntity.h"

@interface WMRepository : NSObject

@property (nonatomic, strong) NSMutableArray *buildings;
@property (nonatomic, strong) NSMutableArray *shows;
@property (nonatomic, strong) NSMutableArray *scheduleShows;

+ (WMRepository *)sharedRepository;

@end

//
//  WMRepository.h
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMRepository : NSObject

@property (nonatomic, strong) NSMutableDictionary *buildings;
@property (nonatomic, strong) NSMutableDictionary *shows;

+ (WMRepository *)sharedRepository;

@end

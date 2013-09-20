//
//  WMRepository.m
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMRepository.h"

static WMRepository *repository = nil;

@implementation WMRepository

+ (WMRepository *)sharedRepository
{
    if (!repository)
    {
        repository = [[WMRepository alloc] init];
        repository.shows = [NSMutableArray new];
        for (NSUInteger i=1; i<20; i++)
        {
            [repository.shows addObject:[NSString stringWithFormat:@"%i", i]];
        }
        repository.scheduleShows = [NSMutableArray new];
    }
    
    return repository;
}


- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self load];
    }
    
    return self;
}


- (void)load
{
    [self.buildings removeAllObjects];
    self.buildings = [NSMutableDictionary new];

    [self.shows removeAllObjects];
    self.shows = [NSMutableArray new];
}

@end

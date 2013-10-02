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
        repository.scheduleShows = [NSMutableArray new];
        [repository load];
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
    self.buildings = [NSMutableArray new];
    NSData *buildingsData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"whu_landscapes" withExtension:@"json"]];
    NSArray *buildings = [NSJSONSerialization JSONObjectWithData:buildingsData
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
    for (NSDictionary *dict in buildings)
    {
        [self.buildings addObject:[WMLandmarkEntity entityWithDictionary:dict]];
    }
    
    [self.shows removeAllObjects];
    self.shows = [NSMutableArray new];
    NSData *showData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"whu_shows" withExtension:@"json"]];
    NSArray *showArray = [NSJSONSerialization JSONObjectWithData:showData
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
    
    for (NSDictionary *dict in showArray)
    {
        [self.shows addObject:[WMShowEntity entityWithDictionary:dict]];
    }
}

@end

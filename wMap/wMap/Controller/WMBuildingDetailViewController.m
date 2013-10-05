//
//  WMBuildingDetailViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 10/1/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingDetailViewController.h"

@interface WMBuildingDetailViewController ()

@property (nonatomic, strong) WMLandmarkEntity *landmarkEntity;

@end

@implementation WMBuildingDetailViewController

- (id)initWithLandmark:(WMLandmarkEntity *)landmarkEntity
              delegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    if (self)
    {
        self.landmarkEntity = landmarkEntity;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.landmarkEntity = self.landmarkEntity;
}

- (Class)viewClass
{
    return [WMBuildingDetailView class];
}

- (NSString *)titleString
{
    return self.landmarkEntity.name;
}

- (NSString *)leftBarButtonTitle
{
    return @"Landmark";
}

@end

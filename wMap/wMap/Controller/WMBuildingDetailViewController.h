//
//  WMBuildingDetailViewController.h
//  wMap
//
//  Created by Shengzhe Chen on 10/1/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMViewController.h"
#import "WMBuildingDetailView.h"

@interface WMBuildingDetailViewController : WMViewController

@property (nonatomic, strong) WMBuildingDetailView *view;

- (id)initWithLandmark:(WMLandmarkEntity *)landmarkEntity
              delegate:(id)delegate;

@end

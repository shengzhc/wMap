//
//  WMBuildingView.h
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMView.h"

@protocol WMBuildingViewDelegate <NSObject>

@optional
- (void)didSelectCollectionViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WMBuildingView : WMView < UICollectionViewDataSource, UICollectionViewDelegate >

@property (nonatomic, strong) id < WMBuildingViewDelegate > delegate;

@end

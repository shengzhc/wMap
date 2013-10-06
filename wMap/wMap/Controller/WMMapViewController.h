//
//  WMMapViewController.h
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface WMMapViewController : WMViewController < MAMapViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate >

- (void)locateWithShowEntity:(WMShowEntity *)showEntity;
- (void)locateWithPOI:(WMAMapPOI *)poi;

@end

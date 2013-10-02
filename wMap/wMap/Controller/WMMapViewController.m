//
//  WMMapViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapViewController.h"
#import "WMMapView.h"

@interface WMMapViewController ()

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation WMMapViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self)
    {
        
    }
    
    return self;
}


- (Class)viewClass
{
    return [WMMapView class];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [MAMapServices sharedServices].apiKey = @"67c5eab4838b21d1f6a4c1cc35b95d00";
    self.navigationItem.leftBarButtonItems = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}


- (NSString *)titleString
{
    return @"地图";
}

@end

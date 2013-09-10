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
    self.navigationItem.leftBarButtonItems = nil;
}

@end

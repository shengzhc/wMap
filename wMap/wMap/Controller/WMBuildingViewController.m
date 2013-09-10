//
//  WMBuildingViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingViewController.h"
#import "WMBuildingView.h"

@interface WMBuildingViewController ()

@end

@implementation WMBuildingViewController

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
    return [WMBuildingView class];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems = nil;
}
@end

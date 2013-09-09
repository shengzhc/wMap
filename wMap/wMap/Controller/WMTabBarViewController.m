//
//  WMTabBarViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMTabBarViewController.h"

@interface WMTabBarViewController ()

@end

@implementation WMTabBarViewController

- (id)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar"]];
}

@end

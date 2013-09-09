//
//  WMShowViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowViewController.h"
#import "WMShowView.h"

@interface WMShowViewController ()

@end

@implementation WMShowViewController

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
    return [WMShowView class];
}

@end

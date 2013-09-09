//
//  WMMapView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapView.h"

@implementation WMMapView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:150 blue:0 alpha:1.0];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end

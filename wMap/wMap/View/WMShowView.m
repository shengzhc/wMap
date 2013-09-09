//
//  WMShowView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowView.h"

@implementation WMShowView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:150 alpha:1.0];

    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end

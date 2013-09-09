//
//  WMNavigationBar.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMNavigationBar.h"

@implementation WMNavigationBar

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIImage *background = [UIImage imageNamed:@"navigation_bar"];
    [background drawInRect:rect];
    [self addShadowWithColor:[UIColor blackColor]];
}

@end

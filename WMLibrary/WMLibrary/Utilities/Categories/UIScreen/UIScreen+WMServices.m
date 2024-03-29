//
//  UIScreen+ICServices.m
//  ICLibrary
//
//  Created by Shengzhe Chen on 7/14/13.
//  Copyright (c) 2013 Shengzhe Chen. All rights reserved.
//

#import "UIScreen+WMServices.h"
#import "ICGeometry.h"

@implementation UIScreen (WMServices)


+ (BOOL)isRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        [UIScreen mainScreen].scale == 2.0)
    {
        return YES;
    }
    
    return NO;
}

+ (CGFloat)screenHeigth
{
    return [[UIScreen mainScreen] applicationFrame].size.height +
    [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)screenWidth
{
    return [[UIScreen mainScreen] applicationFrame].size.width;
}

+ (CGFloat)statusBarHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGPoint)screenCenter
{
    return CGPointMake([UIScreen mainScreen].bounds.size.width/2.0,
                       [UIScreen mainScreen].bounds.size.height/2.0);
}


@end

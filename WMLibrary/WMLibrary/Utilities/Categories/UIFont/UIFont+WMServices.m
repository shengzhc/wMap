//
//  UIFont+ICServices.m
//  ICLibrary
//
//  Created by Shengzhe Chen on 7/19/13.
//  Copyright (c) 2013 Shengzhe Chen. All rights reserved.
//

#import "UIFont+WMServices.h"

@implementation UIFont (WMServices)

+ (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNextCondensed-UltraLight" size:size];
}

+ (UIFont *)fontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:size];
}

+ (UIFont *)boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:size];
}

@end

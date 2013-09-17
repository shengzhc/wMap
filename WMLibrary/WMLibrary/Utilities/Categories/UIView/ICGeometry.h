//
//  KP.h
//  ICLibrary
//
//  Created by Shengzhe Chen on 7/11/13.
//  Copyright (c) 2013 Shengzhe Chen. All rights reserved.
//

#ifndef __ICGEOMETRY_H_
#define __ICGEOMETRY_H_

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

typedef enum
{
    WMAlignmentOptionsLeft          = 1 << 0,
    WMAlignmentOptionsRight         = 1 << 1,
    WMAlignmentOptionsTop           = 1 << 2,
    WMAlignmentOptionsBottom        = 1 << 3,
    WMAlignmentOptionsHorizontalCenter = 1 << 4,
    WMAlignmentOptionsVerticalCenter    = 1 << 5
} WMAlignmentOptions;

CGRect ICSizeAlignInFrame(CGSize size, CGRect frame, CGSize offset, WMAlignmentOptions options);
CGRect ICRectAlignInFrame(CGRect rect, CGRect frame, CGSize offset, WMAlignmentOptions options);
CGFloat ICAlignmentCoordinateWithRelativeFrameHorizontal(CGRect frame, CGFloat padding, WMAlignmentOptions options);
CGFloat ICAlignmentCoordinateWithRelativeFrameVertical(CGRect frame, CGFloat padding, WMAlignmentOptions options);
CGRect ICRectWithOriginAndSize(CGPoint origin, CGSize size);
CGRect ICRectWithOriginAndSizeParameters(CGPoint origin, CGFloat width, CGFloat height);
CGRect ICRectWithOriginCoordinatesAndSize(CGFloat x, CGFloat y, CGSize size);
CGRect ICBooundsWithSize(CGSize size);
CGRect ICBoundsWithSizeParameters(CGFloat width, CGFloat height);

CGRect KPBoundsMake(CGFloat width, CGFloat height);
CGPoint ICFrameMidPoint(CGRect frame);
CGPoint ICPointMake(CGFloat x, CGFloat y);
CGSize ICSizeMake(CGFloat width, CGFloat height);
CGRect ICRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
CGRect ICRectOffset(CGRect rect, CGFloat x, CGFloat y);
CGRect ICRectInset(CGRect rect, CGFloat dx, CGFloat dy);


#endif
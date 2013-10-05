//
//  WMMapView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapView.h"
#import <QuartzCore/QuartzCore.h>

@interface WMMapView ()

@property (nonatomic, strong) UIButton *locatemeButton;
@property (nonatomic, strong) UIButton *trafficButton;

@end

@implementation WMMapView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        
        self.locatemeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.locatemeButton setBackgroundImage:[UIImage imageNamed:@"map_locate"] forState:UIControlStateNormal];
        [self.locatemeButton addTarget:self action:@selector(locatemeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.locatemeButton sizeToFit];

        self.trafficButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.trafficButton setBackgroundImage:[UIImage imageNamed:@"map_traffic"] forState:UIControlStateNormal];
        [self.trafficButton addTarget:self action:@selector(trafficButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.trafficButton sizeToFit];

        [self addSubview:self.locatemeButton];
        [self addSubview:self.trafficButton];
        
        self.locatemeButton.alpha = 0.0;
        self.trafficButton.alpha = 0.0;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)locatemeButtonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(locatemeButtonClicked:)])
    {
        [self.delegate performSelector:@selector(locatemeButtonClicked:) withObject:self];
    }
}

- (void)trafficButtonClicked:(UIButton *)button
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

}

@end

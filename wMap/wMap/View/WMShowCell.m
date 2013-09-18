//
//  WMShowCell.m
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowCell.h"

#define EXTRA_PADDING 60.0
#define VELOCITY 100.0
#define MAX_DURATION 0.3

@interface WMShowCell ()

@property (nonatomic, strong) UIButton *alertButton;
@property (nonatomic, strong) UIButton *locationButton;

@end

@implementation WMShowCell
{
    CGPoint _original;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alertButton addTarget:self
                             action:@selector(alertButtonClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.alertButton setBackgroundImage:[UIImage imageNamed:@"show_alarm"]
                                    forState:UIControlStateNormal];
        [self.alertButton sizeToFit];

        self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.locationButton addTarget:self
                                action:@selector(locationButtonClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.locationButton setBackgroundImage:[UIImage imageNamed:@"show_location"]
                                       forState:UIControlStateNormal];
        [self.locationButton sizeToFit];
        [self.contentView addSubview:self.alertButton];
        [self.contentView addSubview:self.locationButton];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handlePanGestureRecognizer:)];
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.locationButton.center = CGPointMake(-EXTRA_PADDING/2.0, self.bounds.size.height/2.0);
    self.alertButton.center = CGPointMake(self.bounds.size.width+EXTRA_PADDING/2.0, self.bounds.size.height/2.0);
}


- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint transition = [panGestureRecognizer translationInView:self];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _original = self.contentView.center;
        return;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        self.contentView.center = CGPointMake(_original.x + transition.x, _original.y);
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint center = CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds));
        if (self.contentView.center.x > center.x + EXTRA_PADDING)
        {
            CGPoint target = CGPointMake(center.x + EXTRA_PADDING, center.y);
            CGFloat duration = fabsf(self.contentView.center.x - target.x)/VELOCITY;
            [UIView animateWithDuration:(duration < MAX_DURATION ? duration : MAX_DURATION)
                             animations:^
            {
                self.contentView.center = CGPointMake(center.x + EXTRA_PADDING, center.y);
            }];
        }
        else if (self.contentView.center.x < center.x - EXTRA_PADDING)
        {
            CGPoint target = CGPointMake(center.x - EXTRA_PADDING, center.y);
            CGFloat duration = fabsf(self.contentView.center.x - target.x)/VELOCITY;

            [UIView animateWithDuration:(duration < MAX_DURATION ? duration : MAX_DURATION)
                             animations:^
            {
                self.contentView.center = CGPointMake(center.x - EXTRA_PADDING, center.y);
            }];
        }
        else
        {
            CGPoint target = center;
            CGFloat duration = fabsf(self.contentView.center.x - target.x)/VELOCITY;

            [UIView animateWithDuration:(duration < MAX_DURATION ? duration : MAX_DURATION)
                             animations:^
            {
                self.contentView.center = center;
            }];
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint touchInContentView = [self.contentView convertPoint:point fromView:self];
    
    if (CGRectContainsPoint(self.alertButton.frame, touchInContentView))
    {
        return self.alertButton;
    }
    else if (CGRectContainsPoint(self.locationButton.frame, touchInContentView))
    {
        return self.locationButton;
    }
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint touchInContentView = [self.contentView convertPoint:point fromView:self];
    if (CGRectContainsPoint(self.alertButton.frame, touchInContentView) ||
        CGRectContainsPoint(self.locationButton.frame, touchInContentView))
    {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

- (void)alertButtonClicked:(id)sender
{
}

- (void)locationButtonClicked:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

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

@property (nonatomic, strong) UIButton *alarmButton;
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
        self.alarmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.alarmButton addTarget:self
                             action:@selector(alarmButtonClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.alarmButton setBackgroundImage:[UIImage imageNamed:@"show_alarm"]
                                    forState:UIControlStateNormal];
        [self.alarmButton sizeToFit];

        self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.locationButton addTarget:self
                                action:@selector(locationButtonClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.locationButton setBackgroundImage:[UIImage imageNamed:@"show_location"]
                                       forState:UIControlStateNormal];
        [self.locationButton sizeToFit];
        [self.contentView addSubview:self.alarmButton];
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
    self.alarmButton.center = CGPointMake(self.bounds.size.width+EXTRA_PADDING/2.0, self.bounds.size.height/2.0);
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
        CGPoint target;
        if (self.contentView.center.x > center.x + EXTRA_PADDING)
        {
            target = CGPointMake(center.x + EXTRA_PADDING, center.y);
        }
        else if (self.contentView.center.x < center.x - EXTRA_PADDING)
        {
            target = CGPointMake(center.x - EXTRA_PADDING, center.y);
        }
        else
        {
            target = center;
        }
        [self moveContentViewCenterToPoint:target];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint touchInContentView = [self.contentView convertPoint:point fromView:self];
    
    if (CGRectContainsPoint(self.alarmButton.frame, touchInContentView))
    {
        return self.alarmButton;
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
    if (CGRectContainsPoint(self.alarmButton.frame, touchInContentView) ||
        CGRectContainsPoint(self.locationButton.frame, touchInContentView))
    {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

- (void)alarmButtonClicked:(id)sender
{
    UITableView *tableView = (UITableView *)self.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    id addedObject = [[WMRepository sharedRepository].shows objectAtIndex:indexPath.row];
    if (![[WMRepository sharedRepository].scheduleShows containsObject:addedObject])
    {
        [[WMRepository sharedRepository].scheduleShows addObject:addedObject];
    }
    
    [self moveContentViewCenterToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)locationButtonClicked:(id)sender
{
    self.contentView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}


- (void)moveContentViewCenterToPoint:(CGPoint)point
{
    CGFloat duration = fabsf(self.contentView.center.x - point.x)/VELOCITY;
    
    WMShowCell *this = self;
    [UIView animateWithDuration:(duration < MAX_DURATION ? duration : MAX_DURATION)
                     animations:^
    {
        this.contentView.center = point;
    }];
}

@end

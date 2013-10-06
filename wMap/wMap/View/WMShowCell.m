//
//  WMShowCell.m
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowCell.h"

#define EXTRA_PADDING 100.0
#define VELOCITY 300.0
#define MAX_DURATION 0.2

@interface WMShowCell ()

@property (nonatomic, strong) UIButton *alarmButton;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

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
        [self.alarmButton setTitle:@"Schedule" forState:UIControlStateNormal];
        self.alarmButton.titleLabel.font = [UIFont fontWithSize:14];
        [self.alarmButton setTitleColor:[UIColor whiteColor]
                               forState:UIControlStateNormal];
        [self.alarmButton setBackgroundColor:[UIColor colorWithHex:0xFA3F3C]];
        [self.alarmButton sizeToFit];
        
        self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.locationButton addTarget:self
                                action:@selector(locationButtonClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.locationButton setTitle:@"Location" forState:UIControlStateNormal];
        self.locationButton.titleLabel.font = [UIFont fontWithSize:14];
        [self.locationButton setBackgroundColor:[UIColor colorWithHex:0x4C97D4]];
        [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.locationButton sizeToFit];

        [self.contentView addSubview:self.alarmButton];
        [self.contentView addSubview:self.locationButton];
        
        self.logoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.logoImageView];
        
        self.descriptionLabel = [UILabel labelWithFrame:CGRectZero
                                                   text:@""
                                              alignment:NSTextAlignmentLeft
                                                   font:[UIFont fontWithSize:10]
                                              textColor:[UIColor lightGrayColor]];
        self.descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:self.descriptionLabel];
        
        self.nameLabel = [UILabel labelWithFrame:CGRectZero
                                            text:@""
                                       alignment:NSTextAlignmentLeft
                                            font:[UIFont fontWithSize:12]
                                       textColor:[UIColor blackColor]];
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.nameLabel];
        
        self.timeLabel = [UILabel labelWithFrame:CGRectZero
                                            text:@""
                                       alignment:NSTextAlignmentCenter
                                            font:[UIFont fontWithSize:10]
                                       textColor:[UIColor redColor]];
        [self.contentView addSubview:self.timeLabel];
        
        self.addressLabel = [UILabel labelWithFrame:CGRectZero
                                               text:@""
                                          alignment:NSTextAlignmentLeft
                                               font:[UIFont fontWithSize:10]
                                          textColor:[UIColor blackColor]];
        [self.contentView addSubview:self.addressLabel];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handlePanGestureRecognizer:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.alarmButton.frame = [self.alarmButton alignedRectInSuperviewForSize:CGSizeMake(EXTRA_PADDING, self.bounds.size.height/2.0)
                                                                      offset:CGSizeMake(self.bounds.size.width, 0)
                                                                     options:(WMAlignmentOptionsTop | WMAlignmentOptionsLeft)];
    self.locationButton.frame = [self.locationButton alignedRectInSuperviewForSize:CGSizeMake(EXTRA_PADDING, self.bounds.size.height/2.0)
                                                                            offset:CGSizeMake(self.bounds.size.width, self.bounds.size.height/2.0)
                                                                           options:(WMAlignmentOptionsTop | WMAlignmentOptionsLeft)];

    self.logoImageView.frame = [self.logoImageView alignedRectInSuperviewForSize:CGSizeMake(70, 70)
                                                                          offset:CGSizeMake(10, 10)
                                                                         options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    self.nameLabel.frame = [self.nameLabel alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width - self.logoImageView.frame.size.width - 20, 16)
                                                                  offset:CGSizeMake(self.logoImageView.verticalEnding + 10, self.logoImageView.frame.origin.y)
                                                                 options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    [self.addressLabel sizeToFit];
    self.addressLabel.frame = [self.addressLabel alignedRectInSuperviewForSize:self.addressLabel.bounds.size
                                                                        offset:CGSizeMake(self.nameLabel.frame.origin.x, self.nameLabel.verticalEnding + 10)
                                                                       options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = [self.timeLabel alignedRectInSuperviewForSize:self.timeLabel.bounds.size
                                                                  offset:CGSizeMake(self.addressLabel.frame.origin.x, self.addressLabel.verticalEnding + 15)
                                                                 options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    self.descriptionLabel.frame = [self.descriptionLabel alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width - 20, self.bounds.size.height - self.logoImageView.verticalEnding - 10)
                                                                                offset:CGSizeMake(self.logoImageView.frame.origin.x, self.logoImageView.verticalEnding + 2)
                                                                               options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self];
    if (fabs(translation.x) > fabs(translation.y))
    {
        return YES;
    }
    
    return NO;
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(didPanGestureBegin:)])
    {
        [self.delegate performSelector:@selector(didPanGestureBegin:)
                            withObject:self];
    }
    
    CGPoint transition = [panGestureRecognizer translationInView:self];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _original = self.contentView.center;
        return;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint target = CGPointMake(_original.x + transition.x, _original.y);
        if (target.x > self.bounds.size.width/2.0 ||
            target.x < self.bounds.size.width/2.0 - EXTRA_PADDING)
        {
            return;
        }
        else
        {
            self.contentView.center = CGPointMake(_original.x + transition.x, _original.y);
        }
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint center = CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds));
        CGPoint target;
        if (self.contentView.center.x > center.x + EXTRA_PADDING/2.0)
        {
            target = CGPointMake(center.x + EXTRA_PADDING, center.y);
        }
        else if (self.contentView.center.x < center.x - EXTRA_PADDING/2.0)
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
    [self moveContentViewCenterToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    
    if ([self.delegate respondsToSelector:@selector(alarmButtonClicked:)])
    {
        [self.delegate performSelector:@selector(alarmButtonClicked:)
                            withObject:self];
    }
    
}

- (void)locationButtonClicked:(id)sender
{
    [self moveContentViewCenterToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    
    if ([self.delegate respondsToSelector:@selector(locationButtonClicked:)])
    {
        [self.delegate performSelector:@selector(locationButtonClicked:)
                            withObject:self];
    }
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

- (void)setShowEntity:(WMShowEntity *)showEntity
{
    _showEntity = showEntity;
    
    self.nameLabel.text = showEntity.name;
    self.addressLabel.text = showEntity.address;
    self.descriptionLabel.text = showEntity.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    self.timeLabel.text = [formatter stringFromDate:showEntity.date];
    self.logoImageView.image = [UIImage imageNamed:showEntity.image];
    [self setNeedsLayout];
}

@end

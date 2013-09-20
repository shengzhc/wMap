//
//  WMClockViewCell.m
//  wMap
//
//  Created by Shengzhe Chen on 9/17/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMClockViewCell.h"

#define EXTRA_CELL_WIDTH 200

@interface WMClockViewCell ()

@property (nonatomic, strong) UIImageView *removeImageView;
@property (nonatomic, strong) UIView *extraCellView;

@end

@implementation WMClockViewCell
{
    CGPoint _originalCenter;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handlePanGestureRecognizer:)];
        
        [self addGestureRecognizer:panGestureRecognizer];
        
        self.removeImageView = [UIImageView imageViewWithImageNamed:@"cell_trash"];
        self.extraCellView = [[UIView alloc] init];
        self.extraCellView.backgroundColor = [UIColor redColor];
        
        [self.extraCellView addSubview:self.removeImageView];
        [self.contentView addSubview:self.extraCellView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.extraCellView.frame = [self.extraCellView alignedRectInSuperviewForSize:CGSizeMake(EXTRA_CELL_WIDTH, self.contentView.bounds.size.height)
                                                                          offset:CGSizeMake(self.bounds.size.width, 0)
                                                                         options:(WMAlignmentOptionsLeft | WMAlignmentOptionsVerticalCenter)];
    self.removeImageView.frame = [self.removeImageView alignedRectInSuperviewForSize:self.removeImageView.image.size
                                                                              offset:CGSizeMake(20, 0)
                                                                             options:(WMAlignmentOptionsLeft | WMAlignmentOptionsVerticalCenter)];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchInView = [panGestureRecognizer translationInView:self];

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        _originalCenter = self.contentView.center;
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        if (touchInView.x > 0)
        {
            return;
        }
        
        if (fabs(touchInView.x) > EXTRA_CELL_WIDTH)
        {
            [self removeCell];
            panGestureRecognizer.enabled = NO;
            return;
        }
        
        self.contentView.center = CGPointMake(_originalCenter.x + touchInView.x, _originalCenter.y);
        self.extraCellView.alpha = 0.5 + fabs(touchInView.x)/(2 * EXTRA_CELL_WIDTH);
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGFloat x = _originalCenter.x + touchInView.x;
        if (x < 0)
        {
            [self removeCell];
            panGestureRecognizer.enabled = NO;
        }
        else
        {
            WMClockViewCell *this = self;
            [UIView animateWithDuration:.3
                             animations:^
            {
                this.contentView.center = _originalCenter;
            }];
        }
    }
}


- (void)removeCell
{
    if ([self.delegate respondsToSelector:@selector(removeCell:)])
    {
        [self.delegate performSelector:@selector(removeCell:)
                            withObject:self];
    }
}

@end

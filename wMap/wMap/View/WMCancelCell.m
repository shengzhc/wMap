//
//  WMCancelCell.m
//  wMap
//
//  Created by Shengzhe Chen on 9/19/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMCancelCell.h"

@implementation WMCancelCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.textLabel.textColor = [UIColor colorWithHex:0xE65E26];
        self.textLabel.font = [UIFont icBoldFontWithSize:20];
        self.contentView.backgroundColor = [self colorForCellBackground];
        self.textLabel.backgroundColor = [self colorForCellBackground];
        self.selectedBackgroundView = [self selectedViewForCell];
    }
    return self;
}

- (UIColor *)colorForCellBackground
{
    return [UIColor colorWithHex:0xFDFDFD];
}

- (UIView *)selectedViewForCell
{
    return [UIImageView imageViewWithImageNamed:@"cell_selected_background"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = [self.textLabel alignedRectInSuperviewForSize:self.textLabel.bounds.size
                                                                  offset:CGSizeMake(0, 0)
                                                                 options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsVerticalCenter)];
}

@end

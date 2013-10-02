//
//  WMBuildingDetailView.m
//  wMap
//
//  Created by Shengzhe Chen on 10/1/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingDetailView.h"

@interface WMBuildingDetailView ()

@property (nonatomic, strong) UIImageView *landmarkImageView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation WMBuildingDetailView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.landmarkImageView = [[UIImageView alloc] init];
        self.contentView = [[UIScrollView alloc] init];
        
        self.nameLabel = [UILabel labelWithAlignment:NSTextAlignmentCenter
                                                font:[UIFont fontWithSize:22]
                                           textColor:[UIColor blackColor]];
        
        self.descriptionLabel = [UILabel labelWithAlignment:NSTextAlignmentLeft
                                                       font:[UIFont fontWithSize:12]
                                                  textColor:[UIColor lightGrayColor]];
        self.descriptionLabel.numberOfLines = 0;
        
        [self addSubview:self.landmarkImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descriptionLabel];
        [self addSubview:self.contentView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.landmarkImageView.image)
    {
        CGFloat scale = self.bounds.size.width / self.landmarkImageView.image.size.width;
        self.landmarkImageView.frame = [self.landmarkImageView alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, self.landmarkImageView.image.size.height * scale) offset:CGSizeMake(0, 0) options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsTop)];
    }
    
    self.contentView.frame = [self.contentView alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - self.landmarkImageView.bounds.size.height) offset:CGSizeMake(0, self.landmarkImageView.verticalEnding) options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsTop)];
    [self.nameLabel sizeToFit];
    self.nameLabel.frame = [self.nameLabel alignedRectInSuperviewForSize:self.nameLabel.bounds.size
                                                                  offset:CGSizeMake(5, 10)
                                                                 options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    CGSize descSize = [self.descriptionLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 10, MAXFLOAT)];
    self.descriptionLabel.frame = [self.descriptionLabel alignedRectInSuperviewForSize:descSize
                                                                                offset:CGSizeMake(5, self.nameLabel.verticalEnding + 5)
                                                                               options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsTop)];
    self.contentView.contentSize = CGSizeMake(self.bounds.size.width, self.descriptionLabel.verticalEnding + 5);
}

- (void)setLandmarkEntity:(WMLandmarkEntity *)landmarkEntity
{
    _landmarkEntity = landmarkEntity;
    self.landmarkImageView.image = [UIImage imageNamed:landmarkEntity.image];
    self.nameLabel.text = landmarkEntity.name;
    self.descriptionLabel.text = landmarkEntity.desc;
    [self setNeedsLayout];
}
@end

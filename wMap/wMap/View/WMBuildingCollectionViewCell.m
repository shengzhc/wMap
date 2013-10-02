//
//  WMBuildingCollectionViewCell.m
//  wMap
//
//  Created by Shengzhe Chen on 10/1/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingCollectionViewCell.h"

@interface WMBuildingCollectionViewCell ()

@property (nonatomic, strong) WMLandmarkEntity *landmarkEntity;

@property (nonatomic, strong) UIImageView *buildingImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation WMBuildingCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.buildingImageView = [[UIImageView alloc] init];
        self.nameLabel = [UILabel labelWithFrame:CGRectZero
                                            text:@""
                                       alignment:NSTextAlignmentCenter
                                            font:[UIFont fontWithSize:16]
                                       textColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.buildingImageView];
        [self.buildingImageView addSubview:self.nameLabel];
        [self.buildingImageView addCorners];
        self.buildingImageView.clipsToBounds = YES;
        self.nameLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.buildingImageView.frame = self.bounds;
    self.nameLabel.frame = [self.nameLabel alignedRectInSuperviewForSize:CGSizeMake(self.buildingImageView.bounds.size.width, 20)
                                                                  offset:CGSizeMake(0, 0)
                                                                 options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsBottom)];
}

- (void)setData:(id)data
       delegate:(id)delegate
{
    self.landmarkEntity = (WMLandmarkEntity *)data;
    self.delegate = delegate;
    self.buildingImageView.image = [UIImage imageNamed:self.landmarkEntity.image];
    self.nameLabel.text = self.landmarkEntity.name;
    
    [self setNeedsLayout];
}

@end

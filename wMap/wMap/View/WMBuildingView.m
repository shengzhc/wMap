//
//  WMBuildingView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingView.h"
#import "WMVerticalCollectionLayout.h"
#import "WMVerticalCollectionViewCell.h"

static NSString *collectionViewCellIdentifier = @"VerticalCollectionViewCellIdentifier";

@interface WMBuildingView ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WMVerticalCollectionLayout *verticalLayout;

@end

@implementation WMBuildingView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        self.verticalLayout = [[WMVerticalCollectionLayout alloc] init];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                 collectionViewLayout:self.verticalLayout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[WMVerticalCollectionViewCell class]
                forCellWithReuseIdentifier:collectionViewCellIdentifier];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = [self.collectionView alignedRectInSuperviewForSize:self.bounds.size
                                                                            offset:CGSizeMake(0, 0)
                                                                           options:(WMAlignmentOptionsHorizontalCenter | WMAlignmentOptionsVerticalCenter)];
}
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark UICollectionViewDataSource/UICollectionViewDelegate
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    if (attribute.alpha > 0.5)
    {
        NSLog(@"%@", NSStringFromSelector(_cmd));
    }
}

@end

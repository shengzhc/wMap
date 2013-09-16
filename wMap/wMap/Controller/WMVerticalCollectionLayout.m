//
//  WMVerticalCollectionLayout.m
//  wMap
//
//  Created by Shengzhe Chen on 9/15/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMVerticalCollectionLayout.h"

#define CELL_PADDING 20

@interface WMVerticalCollectionLayout ()

@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSIndexPath *highlightIndexPath;

@end

@implementation WMVerticalCollectionLayout

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.attributes = [NSMutableArray new];
        _highlightIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    
    return self;
}

- (CGSize)cellSize
{
    return CGSizeMake(300, 100);
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self.attributes removeAllObjects];
    CGFloat midX = CGRectGetMidX(self.collectionView.frame);
    for (NSInteger i=0; i<[self.collectionView numberOfItemsInSection:0]; i++)
    {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attribute.center = CGPointMake(midX, CELL_PADDING + [self cellSize].height / 2.0 + ([self cellSize].height + CELL_PADDING) * i);
        attribute.size = [self cellSize];
        [self.attributes addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger counts = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.collectionView.bounds.size.width, counts * (CELL_PADDING + [self cellSize].height));
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.attributes objectAtIndex:indexPath.row];
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray new];
    CGPoint center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMidY(self.collectionView.bounds));
    for (UICollectionViewLayoutAttributes *attribute in self.attributes)
    {
        if (CGRectIntersectsRect(rect, attribute.frame))
        {
            if (fabs(attribute.center.y - center.y) < 10.0)
            {
                attribute.transform3D = CATransform3DScale(attribute.transform3D, 0.8, .8, 1.0);
            }
            else
            {
                attribute.transform3D = CATransform3DIdentity;
            }
            
            [attributes addObject:attribute];
        }
    }
    
    return attributes;
}

@end

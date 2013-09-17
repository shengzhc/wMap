//
//  WMVerticalCollectionLayout.m
//  wMap
//
//  Created by Shengzhe Chen on 9/15/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMVerticalCollectionLayout.h"

#define CELL_PADDING 30
#define THREAD_OFFSETY 200.0
#define BASE_ALPHA .3

@interface WMVerticalCollectionLayout ()

@property (nonatomic, strong) NSMutableArray *attributes;

@end

@implementation WMVerticalCollectionLayout

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.attributes = [NSMutableArray new];
    }
    
    return self;
}

- (CGSize)cellSize
{
    return CGSizeMake(280, 150);
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self.attributes removeAllObjects];
    CGFloat midX = CGRectGetMidX(self.collectionView.frame);
    CGFloat midY = CGRectGetMidY(self.collectionView.frame);
    
    for (NSInteger i=0; i<[self.collectionView numberOfItemsInSection:0]; i++)
    {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attribute.center = CGPointMake(midX, midY);
        attribute.size = [self cellSize];
        midY += CELL_PADDING + [self cellSize].height;
        [self.attributes addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger counts = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.collectionView.bounds.size.width, counts * (CELL_PADDING + [self cellSize].height) + self.collectionView.bounds.size.height - [self cellSize].height - CELL_PADDING);
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
            float offsetY = fabsf(attribute.center.y - center.y);
            if (offsetY < THREAD_OFFSETY)
            {
                float factor = (THREAD_OFFSETY - offsetY)/THREAD_OFFSETY;
                CATransform3D transform = CATransform3DScale(CATransform3DIdentity, (1+factor*.1), (1+factor*.1), 1.0);
                attribute.transform3D = transform;
                attribute.alpha = BASE_ALPHA + factor * .8;
            }
            else
            {
                attribute.transform3D = CATransform3DIdentity;
                attribute.alpha = BASE_ALPHA;
            }
            
            [attributes addObject:attribute];
        }
    }
    
    return attributes;
}

@end

//
//  WMBuildingCollectionViewCell.h
//  wMap
//
//  Created by Shengzhe Chen on 10/1/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMBuildingCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id delegate;

- (void)setData:(id)data
       delegate:(id)delegate;

@end

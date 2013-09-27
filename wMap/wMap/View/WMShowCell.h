//
//  WMShowCell.h
//  wMap
//
//  Created by Shengzhe Chen on 9/16/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMShowCell : UITableViewCell < UIGestureRecognizerDelegate >

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) WMShowEntity *showEntity;

- (void)moveContentViewCenterToPoint:(CGPoint)point;

@end

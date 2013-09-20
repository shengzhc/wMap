//
//  WMClockView.h
//  wMap
//
//  Created by Shengzhe Chen on 9/17/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMView.h"

@interface WMClockView : WMView < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, strong) UITableView *tableView;

- (CGRect)adjustTableViewFrame;

@end

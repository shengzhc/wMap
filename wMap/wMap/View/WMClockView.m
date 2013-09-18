//
//  WMClockView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/17/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMClockView.h"
#import "WMClockViewCell.h"

#define WMClockCellIdentifier @"WMClockCellIdentifier"

@interface WMClockView ()

@end

@implementation WMClockView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[WMClockViewCell class]
               forCellReuseIdentifier:WMClockCellIdentifier];
        [self addSubview:self.tableView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark UITableViewDataSource/UITableViewDelegate
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMClockViewCell *cell = (WMClockViewCell *)[tableView dequeueReusableCellWithIdentifier:WMClockCellIdentifier];
    return cell;
}

@end

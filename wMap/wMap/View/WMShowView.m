//
//  WMShowView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowView.h"
#import "WMShowCell.h"

static NSString *showCellIdentifier = @"ShowCellIdentifier";

@interface WMShowView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WMShowView

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate
{
    self = [super initWithFrame:frame
                       delegate:delegate];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[WMShowCell class] forCellReuseIdentifier:showCellIdentifier];
        [self addSubview:self.tableView];
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
#pragma mark UITableViewDataSource/UITableViewDelegate
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMShowCell *cell = (WMShowCell *)[tableView dequeueReusableCellWithIdentifier:showCellIdentifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


@end

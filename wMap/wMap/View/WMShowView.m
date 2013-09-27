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
@property (nonatomic, strong) UITableViewCell *currentSelectionCell;

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
    return [WMRepository sharedRepository].shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMShowCell *cell = (WMShowCell *)[tableView dequeueReusableCellWithIdentifier:showCellIdentifier];
    WMShowEntity *showEntity = [[WMRepository sharedRepository].shows objectAtIndex:indexPath.row];
    cell.showEntity = showEntity;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)alarmButtonClicked:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    if ([self.delegate respondsToSelector:@selector(scheduleShowAtIndexPath:)])
    {
        [self.delegate performSelector:@selector(scheduleShowAtIndexPath:)
                            withObject:indexPath];
    }
    id addedObject = [[WMRepository sharedRepository].shows objectAtIndex:indexPath.row];
    if (![[WMRepository sharedRepository].scheduleShows containsObject:addedObject])
    {
        [[WMRepository sharedRepository].scheduleShows addObject:addedObject];
    }
}

- (void)didPanGestureBegin:(id)sender
{
    WMShowCell *cell = (WMShowCell *)sender;
    
    if (!self.currentSelectionCell)
    {
        self.currentSelectionCell = cell;
        return;
    }
    
    if (self.currentSelectionCell == cell)
    {
        return;
    }
    
    [(WMShowCell *)self.currentSelectionCell moveContentViewCenterToPoint:CGPointMake(CGRectGetMidX(self.currentSelectionCell.bounds), CGRectGetMidY(self.currentSelectionCell.bounds))];
    self.currentSelectionCell = cell;
}


@end

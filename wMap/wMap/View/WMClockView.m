//
//  WMClockView.m
//  wMap
//
//  Created by Shengzhe Chen on 9/17/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMClockView.h"
#import "WMClockViewCell.h"
#import "WMCancelCell.h"

#define WMClockCellIdentifier @"WMClockCellIdentifier"
#define WMCancelCellIdentifier @"WMCancelCellIdentifier"

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
        [self.tableView registerClass:[WMCancelCell class]
               forCellReuseIdentifier:WMCancelCellIdentifier];
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
    return [WMRepository sharedRepository].scheduleShows.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1)
    {
        WMCancelCell *cell = (WMCancelCell *)[tableView dequeueReusableCellWithIdentifier:WMCancelCellIdentifier];
        cell.textLabel.text = @"Cancel";
        return cell;
    }
    else
    {
        WMClockViewCell *cell = (WMClockViewCell *)[tableView dequeueReusableCellWithIdentifier:WMClockCellIdentifier];
        cell.delegate = self;
        WMShowEntity *showEntity = (WMShowEntity *)[[WMRepository sharedRepository].scheduleShows objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithSize:14];
        cell.textLabel.text = showEntity.name;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[WMCancelCell class]])
    {
        if ([self.delegate respondsToSelector:@selector(didClickedCancelCell:)])
        {
            [self.delegate performSelector:@selector(didClickedCancelCell:)
                                withObject:self];
        }
    }
}

- (void)removeCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [[WMRepository sharedRepository].scheduleShows removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                          withRowAnimation:UITableViewRowAnimationFade];
    

    WMClockView *this = self;
    
    [UIView animateWithDuration:.2
                     animations:^
    {
        this.tableView.frame = [this adjustTableViewFrame];
    }
                     completion:^(BOOL finished)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Unschedule Your Local Notification Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }];
}


- (CGRect)adjustTableViewFrame
{
    NSUInteger count = [self.tableView numberOfRowsInSection:0];
    if (count > 5)
    {
        count = 5;
    }
    
    CGFloat height =  count * 44;
    return CGRectMake(0, self.bounds.size.height - height, self.bounds.size.width, height);
}

@end

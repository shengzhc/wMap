//
//  WMShowViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMShowViewController.h"
#import "WMShowView.h"
#import "WMClockView.h"
#import "WMMapViewController.h"

#define CLOCK_TABLE_HEIGHT 220

@interface WMShowViewController ()

@property (nonatomic, strong) WMClockView *clockView;

@end

@implementation WMShowViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"show_clock"] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(clockButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    
    return self;
}


- (Class)viewClass
{
    return [WMShowView class];
}

- (NSString *)titleString
{
    return @"节目";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems = nil;
}

- (WMClockView *)clockView
{
    if (!_clockView)
    {
        CGRect bounds = [UIScreen mainScreen].bounds;
        _clockView = [[WMClockView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)
                                               delegate:self];
    }
    
    return _clockView;
}

- (void)clockButtonClicked:(id)sender
{
    __block CGRect frame = [self.clockView adjustTableViewFrame];
    self.clockView.tableView.frame = CGRectMake(0, self.clockView.bounds.size.height, self.clockView.bounds.size.width, frame.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self.clockView];
    __block WMShowViewController *this = self;
    [UIView animateWithDuration:.2
                     animations:^
    {
        this.clockView.tableView.frame = frame;
    }];
}

- (void)didClickedCancelCell:(id)sender
{
    __block CGRect frame = [self.clockView adjustTableViewFrame];
    __block WMShowViewController *this = self;
    [UIView animateWithDuration:.2
                     animations:^
    {
        this.clockView.tableView.frame = CGRectMake(0, this.clockView.bounds.size.height, this.clockView.bounds.size.width, frame.size.height);
    }
                     completion:^(BOOL finished)
    {
        [_clockView removeFromSuperview];
        _clockView = nil;
    }];
}

- (void)scheduleShowAtIndexPath:(NSIndexPath *)indexPath
{
    WMShowEntity *showEntity = (WMShowEntity *)[[WMRepository sharedRepository].shows
                                                objectAtIndex:indexPath.row];
    
    if (![[WMRepository sharedRepository].scheduleShows containsObject:showEntity])
    {
        [[WMRepository sharedRepository].scheduleShows addObject:showEntity];
        [WMLocalNotificationManager scheduleLocalNotificationWithShowEntity:showEntity];
    }
}

- (void)redirectToMMapLocationAtIndexPath:(NSIndexPath *)indexPath
{
    WMShowEntity *showEntity = (WMShowEntity *)[[WMRepository sharedRepository].shows
                                                objectAtIndex:indexPath.row];
    
    WMMapViewController *mapViewController = (WMMapViewController *)[((UINavigationController *)self.tabBarController.viewControllers[1]).viewControllers objectAtIndex:0];
    [self.tabBarController setSelectedIndex:1];
    [mapViewController locateWithShowEntity:showEntity];
}
@end

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
    self.clockView.tableView.frame = CGRectMake(0, self.clockView.bounds.size.height, self.clockView.bounds.size.width, CLOCK_TABLE_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self.clockView];
    __block WMShowViewController *this = self;
    [UIView animateWithDuration:.2
                     animations:^
    {
        this.clockView.tableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - CLOCK_TABLE_HEIGHT, [UIScreen mainScreen].bounds.size.width, CLOCK_TABLE_HEIGHT);
    }];
}

- (void)didClickedCancelCell:(id)sender
{
    [UIView animateWithDuration:.2
                     animations:^
    {
        _clockView.tableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, CLOCK_TABLE_HEIGHT);
    }
                     completion:^(BOOL finished)
    {
        [_clockView removeFromSuperview];
        _clockView = nil;
    }];
}

@end

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
    CGFloat height = 300.0;
    self.clockView.tableView.frame = CGRectMake(0, self.clockView.bounds.size.height, self.clockView.bounds.size.width, height);
    [[UIApplication sharedApplication].keyWindow addSubview:self.clockView];
    __block WMShowViewController *this = self;
    [UIView animateWithDuration:.2
                     animations:^
    {
        this.clockView.tableView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, [UIScreen mainScreen].bounds.size.width, height);
    }];
}

@end

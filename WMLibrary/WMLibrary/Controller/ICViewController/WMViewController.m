//
//  ICViewController.m
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/4/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import "WMViewController.h"
#import "WMView.h"
#import "UIFont+WMFont.h"
#import "UIFont+WMServices.h"
#import "UIImageView+WMServices.h"
#import "UILabel+WMServices.h"

@interface WMViewController ()

@property (nonatomic, strong) WMView *view;

@end

@implementation WMViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        if ([UIViewController instancesRespondToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [self titleLabel];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *spacingButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spacingButtonItem setWidth:10];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spacingButtonItem, [self leftBarButtonItem], nil];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view removeFromSuperview];
}

- (void)loadView
{
    self.view = [[[self viewClass] alloc] initWithFrame:[self viewFrame]
                                               delegate:self];
}

- (UILabel *)titleLabel
{
    UILabel *label = [UILabel labelWithFrame:CGRectZero
                                        text:[self titleString]
                                   alignment:NSTextAlignmentCenter
                                        font:[UIFont boldFontWithSize:20]
                                   textColor:[UIColor  blackColor]];
    [label sizeToFit];
    return label;
}

- (NSString *)titleString
{
    return @"";
}


- (UIBarButtonItem *)leftBarButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithSize:16];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:[self leftBarButtonTitle] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}


- (NSString *)leftBarButtonTitle
{
    return @"Back";
}


- (Class)viewClass
{
    return [WMView class];
}

- (CGRect)viewFrame
{
    return [UIScreen mainScreen].applicationFrame;
}


- (void)leftBarButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end

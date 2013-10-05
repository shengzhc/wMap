//
//  WMBuildingViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMBuildingViewController.h"
#import "WMBuildingDetailViewController.h"

@interface WMBuildingViewController ()

@end

@implementation WMBuildingViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self)
    {
        
    }
    
    return self;
}


- (Class)viewClass
{
    return [WMBuildingView class];
}

- (NSString *)titleString
{
    return @"Landmark";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems = nil;
}

- (void)didSelectCollectionViewAtIndexPath:(NSIndexPath *)indexPath
{
    WMBuildingDetailViewController *detailViewController = [[WMBuildingDetailViewController alloc] initWithLandmark:[[WMRepository sharedRepository].buildings objectAtIndex:indexPath.row] delegate:self];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end

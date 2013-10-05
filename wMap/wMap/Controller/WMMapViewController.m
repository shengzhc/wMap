//
//  WMMapViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapViewController.h"
#import "WMMapView.h"

@interface WMMapViewController ()

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIButton *widgetButton;

@end

@implementation WMMapViewController

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
    return [WMMapView class];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [MAMapServices sharedServices].apiKey = @"67c5eab4838b21d1f6a4c1cc35b95d00";
    self.navigationItem.leftBarButtonItems = nil;
    
    self.widgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.widgetButton setImage:[UIImage imageNamed:@"map_plus"] forState:UIControlStateNormal];
    [self.widgetButton sizeToFit];
    [self.widgetButton addTarget:self action:@selector(widgetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.widgetButton];;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view insertSubview:self.mapView atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
}

- (NSString *)titleString
{
    return @"Map";
}
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
#pragma mark ActionSheetDelegate
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self locatemeButtonClicked:nil];
            break;
        case 1:
            self.mapView.showTraffic = YES;
            break;
            
        default:
            break;
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    [self iterateActionSheetView:actionSheet];
}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
#pragma mark Convenient
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)iterateActionSheetView:(UIView *)view
{
    if (!view) {
        return;
    }
    
    if (view.subviews && view.subviews.count > 0)
    {
        for (UIView *s in view.subviews)
        {
            if ([s isKindOfClass:[UILabel class]])
            {
                [((UILabel *)s) setFont:[UIFont fontWithSize:16]];
            }
            [self iterateActionSheetView:s];
        }
    }
}

- (void)locateWithShowEntity:(WMShowEntity *)showEntity
{
    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMake(CLLocationCoordinate2DMake([showEntity.latitude floatValue], [showEntity.longitude floatValue]), MACoordinateSpanMake(0.003, 0.004)));
    
    [self.mapView setVisibleMapRect:rect];
    [self.mapView removeAnnotation:showEntity];
    [self.mapView addAnnotation:showEntity];
}
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
#pragma mark Map
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
#pragma mark Button
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)widgetButtonClicked:(UIButton *)button
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Current Location", @"Show Current Traffic", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)locatemeButtonClicked:(UIButton *)button
{
    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMake(self.mapView.userLocation.location.coordinate, MACoordinateSpanMake(0.003, 0.004)));
    [self.mapView setVisibleMapRect:rect];
    
}



@end

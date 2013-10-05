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
@property (nonatomic, strong) id < MAAnnotation > selectedAnnotation;

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
#pragma mark ActionSheetDelegate
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 1:
            [self openExternalMapApplication];
            break;
            
        default:
            break;
    }
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
    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMake(CLLocationCoordinate2DMake([showEntity.latitude floatValue], [showEntity.longitude floatValue]), MACoordinateSpanMake(0.0003, 0.0004)));
    
    [self.mapView setVisibleMapRect:rect];
    [self.mapView removeAnnotation:showEntity];
    [self.mapView addAnnotation:showEntity];
}

- (void)openExternalMapApplication
{
    NSURL *url = [NSURL URLWithString:@"scheme:iosamap"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app//id461703208?mt=8"]];
    }
}
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
#pragma mark Map
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    [self locatemeButtonClicked:nil];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    static NSString *annotationViewIdentifier = @"annotationViewIdentifier";
    
    if ([annotation isKindOfClass:[WMShowEntity class]])
    {
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
        if (!annotationView)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"pin"];
            
            UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [navigationButton setBackgroundImage:[UIImage imageNamed:@"map_traffic"] forState:UIControlStateNormal];
            [navigationButton sizeToFit];
            [navigationButton addTarget:self action:@selector(navigationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = navigationButton;
            
            double delayInSeconds = .3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [annotationView setSelected:YES animated:YES];
            });
        }

        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{

}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    self.selectedAnnotation = view.annotation;
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

- (void)navigationButtonClicked:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Do you want to open GaoDe Map?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView show];
}

@end

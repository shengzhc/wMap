//
//  WMMapSearchViewController.m
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapSearchViewController.h"
#import "WMMapSearchView.h"
#import "WMMapViewController.h"

@interface WMMapSearchViewController ()

@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) WMMapSearchView *view;

@end

@implementation WMMapSearchViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super initWithDelegate:delegate];
    
    if (self)
    {
    
        self.searchResults = [NSMutableArray array];
        self.search = [[AMapSearchAPI alloc] initWithSearchKey:@"67c5eab4838b21d1f6a4c1cc35b95d00" Delegate:self];
    }
    
    return self;
}

- (Class)viewClass
{
    return [WMMapSearchView class];
}

- (NSString *)leftBarButtonTitle
{
    return @"Done";
}

- (NSString *)titleString
{
    return @"Map Search";
}

- (void)leftBarButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(backButtonClicked:)])
    {
        [self.delegate performSelector:@selector(backButtonClicked:) withObject:sender];
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark AMapSearchDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)search:(id)searchRequest error:(NSString*)errInfo
{
    
}

- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    [self.searchResults removeAllObjects];
    [self.searchResults addObjectsFromArray:response.pois];
    [self.view.tableView reloadData];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
}

- (void)onBusLineSearchDone:(AMapBusLineSearchRequest *)request response:(AMapBusLineSearchResponse *)response
{
    
}

- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response
{
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UISearchBarDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    AMapPlaceSearchRequest *searchRequest = [[AMapPlaceSearchRequest alloc] init];
    searchRequest.searchType = AMapSearchType_PlaceAround;
    searchRequest.keywords = searchText;
    searchRequest.radius = 1000 * 1000;
    searchRequest.location = [AMapGeoPoint locationWithLatitude:30.539769878193066 longitude:114.36088979244232];
    searchRequest.requireExtension = YES;
    [self.search AMapPlaceSearch:searchRequest];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.view endEditing:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableViewDataSource & UITableViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    AMapPOI *poi = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = poi.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI *poi = [self.searchResults objectAtIndex:indexPath.row];
    WMAMapPOI *mapPoi = [WMAMapPOI entityWithAMapPOI:poi];
    [((WMMapViewController *)self.delegate) locateWithPOI:mapPoi];
}

@end

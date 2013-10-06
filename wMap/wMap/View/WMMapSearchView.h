//
//  WMMapSearchView.h
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMView.h"

@interface WMMapSearchView : WMView < UISearchBarDelegate >

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@end

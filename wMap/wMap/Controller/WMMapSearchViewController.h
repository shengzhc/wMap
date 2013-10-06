//
//  WMMapSearchViewController.h
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>

@interface WMMapSearchViewController : WMViewController < AMapSearchDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@end

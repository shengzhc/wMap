//
//  WMMapSearchView.m
//  wMap
//
//  Created by Shengzhe Chen on 10/5/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMMapSearchView.h"

@interface WMMapSearchView ()

@end

@implementation WMMapSearchView

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame delegate:delegate];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.delegate = delegate;
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = delegate;
        self.tableView.delegate = delegate;
        
        [self addSubview:self.searchBar];
        [self addSubview:self.tableView];
        
        self.searchBar.frame = [self.searchBar alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, 44) offset:CGSizeMake(0, 0) options:(WMAlignmentOptionsTop | WMAlignmentOptionsLeft)];

        self.tableView.frame = [self.tableView alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - self.searchBar.bounds.size.height) offset:CGSizeMake(0, self.searchBar.verticalEnding) options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.searchBar.frame = [self.searchBar alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, 44) offset:CGSizeMake(0, 0) options:(WMAlignmentOptionsTop | WMAlignmentOptionsLeft)];
    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.tableView.frame = [self.tableView alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - self.searchBar.bounds.size.height - kbSize.height) offset:CGSizeMake(0, self.searchBar.verticalEnding) options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.tableView.frame = [self.tableView alignedRectInSuperviewForSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height - self.searchBar.bounds.size.height) offset:CGSizeMake(0, self.searchBar.verticalEnding) options:(WMAlignmentOptionsLeft | WMAlignmentOptionsTop)];
}


@end

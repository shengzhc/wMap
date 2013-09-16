//
//  WMAppDelegate.m
//  wMap
//
//  Created by Shengzhe Chen on 9/8/13.
//  Copyright (c) 2013 Bros. All rights reserved.
//

#import "WMAppDelegate.h"
#import "WMTabBarViewController.h"
#import "WMBuildingViewController.h"
#import "WMMapViewController.h"
#import "WMShowViewController.h"

#import "WMNavigationBar.h"

@interface WMAppDelegate ()

@property (nonatomic, strong) WMTabBarViewController *tabBarViewController;

@end

@implementation WMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    [self setupTabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setupTabBarController
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                            UITextAttributeTextColor : [UIColor blackColor],
                                 UITextAttributeFont : [UIFont icBoldFontWithSize:12] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blueColor],
                                 UITextAttributeFont : [UIFont icBoldFontWithSize:12] }
                                             forState:UIControlStateHighlighted];

    _tabBarViewController = [[WMTabBarViewController alloc] init];
    [_tabBarViewController.tabBar setSelectionIndicatorImage:[UIImage imageWithColor:[UIColor clearColor]
                                                                                size:CGSizeMake(1, 1)]];
    
    
    
    WMBuildingViewController *buildingViewController = [[WMBuildingViewController alloc] initWithDelegate:self];
    UINavigationController *buildingNav = [[UINavigationController alloc] initWithNavigationBarClass:[WMNavigationBar class] toolbarClass:nil];
    [buildingNav addChildViewController:buildingViewController];
    UITabBarItem *buildingTabItem = [[UITabBarItem alloc] initWithTitle:@"地标" image:nil tag:0];
    [buildingTabItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_university_press"]
                  withFinishedUnselectedImage:[UIImage imageNamed:@"tab_university"]];
    buildingNav.tabBarItem = buildingTabItem;
    
    WMMapViewController *mapViewController = [[WMMapViewController alloc] initWithDelegate:self];
    UINavigationController *mapNav = [[UINavigationController alloc] initWithNavigationBarClass:[WMNavigationBar class] toolbarClass:nil];
    [mapNav addChildViewController:mapViewController];
    UITabBarItem *mapTabBarItem = [[UITabBarItem alloc] initWithTitle:@"地图" image:nil tag:0];
    [mapTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_map_press"]
                withFinishedUnselectedImage:[UIImage imageNamed:@"tab_map"]];
    mapNav.tabBarItem = mapTabBarItem;

    WMShowViewController *showViewController = [[WMShowViewController alloc] initWithDelegate:self];
    UINavigationController *showNav = [[UINavigationController alloc] initWithNavigationBarClass:[WMNavigationBar class] toolbarClass:nil];
    [showNav addChildViewController:showViewController];
    UITabBarItem *showTabBarItem = [[UITabBarItem alloc] initWithTitle:@"节目" image:nil tag:0];
    [showTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_show_press"]
                 withFinishedUnselectedImage:[UIImage imageNamed:@"tab_show"]];
    showNav.tabBarItem = showTabBarItem;

    [_tabBarViewController setViewControllers:[NSArray arrayWithObjects:buildingNav, mapNav, showNav, nil]];
    self.window.rootViewController = _tabBarViewController;

}

@end

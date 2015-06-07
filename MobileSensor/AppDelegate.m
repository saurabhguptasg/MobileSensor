//
//  AppDelegate.m
//  MobileSensor
//
//  Created by Saurabh Gupta on 5/31/15.
//  Copyright (c) 2015 Pivotal. All rights reserved.
//

#import "AppDelegate.h"
#import "MSBaseTabBarViewController.h"
#import "MSDashboardViewController.h"
#import "MSSensorSelectorViewController.h"
#import "WidgetManager.h"
#import "MSSensorUtils.h"
#import "UIImage+FontAwesome.h"
#import "MSSettingsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    //load up the singleton
    WidgetManager *widgetManager = [WidgetManager instance];
    NSLog(@"[[MSSensorUtils instance] screenSize] = %@", NSStringFromCGSize([[MSSensorUtils instance] screenSize]));

    MSDashboardViewController *dashboardViewController = [[MSDashboardViewController alloc] init];
    UINavigationController *navDashboardViewController = [[UINavigationController alloc] initWithRootViewController:dashboardViewController];
    navDashboardViewController.tabBarItem.title = @"Dashboard";
    navDashboardViewController.tabBarItem.image = [UIImage imageWithIcon:@"fa-tachometer"
                                                         backgroundColor:[UIColor clearColor]
                                                               iconColor:[UIColor lightTextColor]
                                                                 andSize:CGSizeMake(20, 20)];

    MSSensorSelectorViewController *selectorViewController = [[MSSensorSelectorViewController alloc] init];
    UINavigationController *navSelectorViewController = [[UINavigationController alloc] initWithRootViewController:selectorViewController];
    navSelectorViewController.tabBarItem.title = @"Sensors";
    navSelectorViewController.tabBarItem.image = [UIImage imageWithIcon:@"fa-check-circle-o"
                                                        backgroundColor:[UIColor clearColor]
                                                              iconColor:[UIColor lightTextColor]
                                                                andSize:CGSizeMake(20, 20)];

    MSSettingsViewController *settingsViewController = [[MSSettingsViewController alloc] init];
    UINavigationController *navSettingsViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    navSettingsViewController.tabBarItem.title = @"Settings";
    navSettingsViewController.tabBarItem.image = [UIImage imageWithIcon:@"fa-cog"
                                                     backgroundColor:[UIColor clearColor]
                                                           iconColor:[UIColor lightTextColor]
                                                             andSize:CGSizeMake(20, 20)];

    MSBaseTabBarViewController *rootViewController = [[MSBaseTabBarViewController alloc] init];
    [rootViewController setViewControllers:@[navDashboardViewController,navSelectorViewController,navSettingsViewController]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:rootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

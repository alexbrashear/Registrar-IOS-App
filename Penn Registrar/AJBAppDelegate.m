//
//  AJBAppDelegate.m
//  Penn Registrar
//
//  Created by Alex Brashear on 7/31/14.
//  Copyright (c) 2014 Alex Brashear. All rights reserved.
//

#import "AJBAppDelegate.h"
#import "AJBSectionsTableViewController.h"
#import <HockeySDK/HockeySDK.h>
#import "AJBCourseDataModel.h"
#import "AJBCoreDataManager.h"
#import "AJBCourseDataFetcher.h"


@implementation AJBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupHockey];
    [self setUpCoreDataInBackground];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    AJBSectionsTableViewController *masterViewController = [[AJBSectionsTableViewController alloc] initWithNibName:nil bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
            
    return YES;
}

- (void)setupHockey {
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"1505c5ff29b9787cff775c6225cb1aaf"];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[AJBCoreDataManager sharedManager] saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[AJBCoreDataManager sharedManager] saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[AJBCoreDataManager sharedManager] saveContext];
}

# pragma mark - setup in background

- (void)setUpCoreDataInBackground {
    [AJBCourseDataFetcher retrieveDepartmentData];
    [AJBCourseDataFetcher retrieveCourseData];
}





@end

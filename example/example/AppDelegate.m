//
//  AppDelegate.m
//  example
//
//  Created by ice on 2/6/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import "AppDelegate.h"
#import "IceTopTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    IceTopTabBarController *ttb =[[IceTopTabBarController alloc] init];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.topTabBarItem = [[IceTopBarItem alloc] initWithText:@"redTab"];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.topTabBarItem = [[IceTopBarItem alloc] initWithText:@"yellowTab"];
    
    UIViewController *vc3 =  [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor greenColor];
    vc3.topTabBarItem = [[IceTopBarItem alloc] initWithText:@"greenTab"];
    
    UIViewController *vc4 =  [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor blackColor];
    vc4.topTabBarItem = [[IceTopBarItem alloc] initWithText:@"blackTab"];
    
    ttb.viewControllers = @[vc1,vc2,vc3,vc4];
    
//    ttb.topTabBar.indicatorColor = [UIColor cyanColor];
//    ttb.topTabBar.indicatorHeight = 1.0f;
//    ttb.topTabBar.titileNormalColor = [UIColor greenColor];
//    ttb.topTabBar.titleSelectedColor = [UIColor cyanColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ttb];
    
    
    self.window.rootViewController = nav;
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

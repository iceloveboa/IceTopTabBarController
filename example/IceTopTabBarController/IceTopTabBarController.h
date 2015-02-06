//
//  IceTopTabBarController.h
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceTopBarItem.h"
#import "IceTopTabBar.h"

@class IceTopTabBar,IceTopBarItem,IceTopTabBarControllerDelegate;
@protocol IceTopTabBarControllerDelegate;

@interface IceTopTabBarController : UIViewController


@property(nonatomic,copy) NSArray *viewControllers;


@property(nonatomic,assign) UIViewController *selectedViewController; // This may return the "More" navigation controller if it exists.
@property(nonatomic) NSUInteger selectedIndex;


@property(nonatomic,readonly) IceTopTabBar *topTabBar ; // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.

@property(nonatomic,assign) id<IceTopTabBarControllerDelegate> delegate;

@end

@protocol IceTopTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(IceTopTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController ;
- (void)tabBarController:(IceTopTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;


//- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                      interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController;
//
//- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                              toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
@end


@interface UIViewController (IceTopTabBarControllerDelegate)

@property(nonatomic,retain) IceTopBarItem *topTabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

//@property(nonatomic,readonly,retain) IceTopTabBarController *topTabBarController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end


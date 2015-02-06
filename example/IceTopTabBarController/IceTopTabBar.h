//
//  IceTopTabBar.h
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IceTopTabBarDelegate;
@class IceTopBarItem;

typedef NS_ENUM(NSInteger, IceTopTabBarItemPositioning) {
    IceTopTabBarItemPositioningAutomatic,
    IceTopTabBarItemPositioningFill,
    IceTopTabBarItemPositioningCentered,
};

@interface IceTopTabBar : UIScrollView

@property(nonatomic,strong)UIColor *indicatorColor;
@property(nonatomic,assign)CGFloat indicatorHeight;
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,strong)UIColor *titileNormalColor;
@property(nonatomic,strong)UIColor *titleSelectedColor;
@property(nonatomic,weak) id<IceTopTabBarDelegate> iceTopBardelegate;
@property(nonatomic,copy)   NSArray *items;
@property(nonatomic,assign) IceTopBarItem  *selectedItem;
@property(nonatomic,assign) int selectedIndex;

-(void)animateWithOffsetX:(CGFloat )offsetX;
@end

@protocol IceTopTabBarDelegate<NSObject>
@optional

- (void)topTabBar:(IceTopTabBar *)tabBar didSelectItem:(IceTopBarItem *)item;

@end
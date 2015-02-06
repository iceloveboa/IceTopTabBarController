//
//  IceTopTabBarController.m
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import "IceTopTabBarController.h"
#import "IceTopTabBar.h"
#import "IceTopBarItem.h"


#define ICETABBARHEIGHT 40



@interface IceTopTabBarController ()<IceTopTabBarDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrollView;

@end

@implementation IceTopTabBarController

-(instancetype)init{
    self = [super init];
    if (self) {
        _topTabBar = [[IceTopTabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ICETABBARHEIGHT)];
        _topTabBar.iceTopBardelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    [self.view addSubview:_topTabBar];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topTabBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-ICETABBARHEIGHT)];
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    // Do any additional setup after loading the view.
    NSMutableArray *topBarItems = [[NSMutableArray alloc] init];
    CGFloat startX = 0;
    for (UIViewController * vc in _viewControllers) {
        UIView *v = vc.view;
        CGRect frame = vc.view.frame;
        frame.origin.x = startX;
        v.frame = frame;
        [_contentScrollView addSubview:v];
        startX += CGRectGetWidth(self.view.frame);
        
        [topBarItems addObject:vc.topTabBarItem];
    }
    _contentScrollView.contentSize = CGSizeMake(startX, CGRectGetHeight(_contentScrollView.frame));
    _topTabBar.items = topBarItems;
    
}

-(void)viewDidLayoutSubviews
{
    _contentScrollView.contentSize = CGSizeMake(_viewControllers.count*CGRectGetWidth(_contentScrollView.frame), CGRectGetHeight(_contentScrollView.frame));
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IceTopTabBarDelegate

-(void)topTabBar:(IceTopTabBar *)tabBar didSelectItem:(IceTopBarItem *)item{
    [_contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame)*item.index, 0) animated:YES];
}


#pragma mark - UIScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    int index = x / CGRectGetWidth(self.view.frame);
    [self.topTabBar setSelectedIndex:index];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.topTabBar animateWithOffsetX:scrollView.contentOffset.x];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

#import <objc/runtime.h>

static const void *topTabBarItemKey = &topTabBarItemKey;

@implementation  UIViewController (IceTopTabBarControllerDelegate)

-(IceTopBarItem *)topTabBarItem{
    return objc_getAssociatedObject(self, topTabBarItemKey);
}

-(void)setTopTabBarItem:(IceTopBarItem *)topTabBarItem{
    objc_setAssociatedObject(self, topTabBarItemKey, topTabBarItem, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


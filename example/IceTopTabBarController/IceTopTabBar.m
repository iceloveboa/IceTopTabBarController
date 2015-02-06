//
//  IceTopTabBar.m
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import "IceTopTabBar.h"
#import "IceTopBarItem.h"

#define ICETOPTABBARITEMFONTSIZE 12
#define ICETOPTABBARFLOATVIEWPADDING 10
#define ICETOPTABBARFLOATVIEWHEIGHT 4
#define ICETOPTABBARFLOATVIEWANIMATIONDURATION .5f
@interface IceTopTabBar()

@property(nonatomic,strong)NSArray *displayItems;
@property(nonatomic,strong)UIView *floatView;
@property(nonatomic,assign)CGFloat indiWidth;
@property(nonatomic,assign)BOOL isTagClicked;
@end

@implementation IceTopTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorColor = [UIColor redColor];
        self.indicatorHeight = ICETOPTABBARFLOATVIEWHEIGHT;
        self.titileNormalColor = [UIColor blackColor];
        self.titleSelectedColor = [UIColor redColor];
        self.titleFont = [UIFont systemFontOfSize:ICETOPTABBARITEMFONTSIZE];
        self.isTagClicked = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.backgroundColor = [UIColor whiteColor];
    _indiWidth = CGRectGetWidth(rect)/_items.count;
    CGFloat startX = 0;
    int index = 0;
    NSMutableArray *displayItems = [[NSMutableArray alloc] init];
    for (IceTopBarItem *tbi in _items) {
       
        tbi.index = index;
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(startX, 0, _indiWidth, CGRectGetHeight(rect));
        [b setTitle:tbi.text forState:UIControlStateNormal];
        [b setTitleColor:_titileNormalColor forState:UIControlStateNormal];
        [b setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        b.titleLabel.textAlignment = NSTextAlignmentCenter;
        b.titleLabel.font = _titleFont;
        b.backgroundColor = [UIColor whiteColor];
        [b addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        b.tag = index;
        [displayItems addObject:b];
        [self addSubview:b];
        startX += _indiWidth;
        index++;
    }
    _displayItems = [NSArray arrayWithArray:displayItems];
    
    _floatView = [[UIView alloc] initWithFrame:CGRectMake(ICETOPTABBARFLOATVIEWPADDING, CGRectGetHeight(rect)-_indicatorHeight, _indiWidth-2*ICETOPTABBARFLOATVIEWPADDING, _indicatorHeight)];
    _floatView.backgroundColor = _indicatorColor;
    [self addSubview:_floatView];
    
    [self setSelectedIndex:0];
}

-(void)buttonClicked:(UIButton *)sender{
    _isTagClicked = YES;
    int index = (int)sender.tag;
    [self setSelectedIndex:index];
}

-(void)setSelectedItem:(IceTopBarItem *)selectedItem{
    UIButton *b = _displayItems[selectedItem.index];
    if (!b.selected) {
        [self resetItems];
        if ([self.iceTopBardelegate respondsToSelector:@selector(topTabBar:didSelectItem:)]) {
            [self.iceTopBardelegate topTabBar:self didSelectItem:selectedItem];
        }
        b.selected = YES;
        
        [UIView animateWithDuration:ICETOPTABBARFLOATVIEWANIMATIONDURATION animations:^{
            CGRect frame = _floatView.frame;
            frame.origin.x = selectedItem.index * _indiWidth+ICETOPTABBARFLOATVIEWPADDING;
            _floatView.frame = frame;
        } completion:^(BOOL finished) {
            _isTagClicked = NO;
        }];
    }
}

-(void)resetItems{
    for (UIButton *b in _displayItems) {
        b.selected = NO;
    }
}

-(void)setSelectedIndex:(int)selectedIndex{
    [self setSelectedItem:_items[selectedIndex]];
}

-(void)animateWithOffsetX:(CGFloat )offsetX{
    if (_isTagClicked) {
        return ;
    }
    int scale = (int)CGRectGetWidth(self.frame)/_indiWidth;
    CGFloat actualOffset = offsetX/scale;
    CGRect frame = _floatView.frame;
    CGFloat calcuX = actualOffset;
    if (calcuX <= 0) {
        frame.origin.x = ICETOPTABBARFLOATVIEWPADDING;
    }else if(calcuX >= _indiWidth * (_items.count-1)){
        frame.origin.x = _indiWidth * (_items.count-1) + ICETOPTABBARFLOATVIEWPADDING;
    }else{
        frame.origin.x = calcuX + ICETOPTABBARFLOATVIEWPADDING;
    }
    _floatView.frame = frame;
}

@end

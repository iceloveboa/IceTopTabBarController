//
//  IceTopBarItem.h
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IceTopBarItem : NSObject

@property(nonatomic,strong)NSString *text;
@property(nonatomic,assign)int index;
-(instancetype)initWithText:(NSString *)text;

@end

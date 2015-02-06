//
//  IceTopBarItem.m
//  IceTabBarController
//
//  Created by ice on 2/5/15.
//  Copyright (c) 2015 ice. All rights reserved.
//

#import "IceTopBarItem.h"



@interface IceTopBarItem ()<NSCopying>



@end


@implementation IceTopBarItem

-(instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self) {
        self.text = text;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    IceTopBarItem *newIceTopBarItem = [[[self class] allocWithZone:zone]init];
    newIceTopBarItem.text = [_text copyWithZone:zone];
    return newIceTopBarItem;
}


@end

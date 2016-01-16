//
//  Player.m
//  AdventureGame
//
//  Created by Anthony Tulai on 2016-01-13.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

#import "Player.h"
#import "PathSegment.h"

@implementation Player

-(instancetype)init {
    self = [super init];
    if (self) {
        _distanceTravelled = 0;
        _wealth = 0;
        _health = 100;
        _location = [[PathSegment alloc] init];
    }
    return self;
}

@end

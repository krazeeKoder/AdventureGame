//
//  Player.h
//  AdventureGame
//
//  Created by Anthony Tulai on 2016-01-13.
//  Copyright © 2016 Cory Alder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathSegment.h"

@interface Player : NSObject

@property (nonatomic, assign) int health;
@property (nonatomic, assign) int wealth;
@property (nonatomic, strong) PathSegment *location;
@property (assign) int distanceTravelled;


@end

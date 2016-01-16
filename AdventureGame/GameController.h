//
//  GameController.h
//  AdventureGame


#import <Foundation/Foundation.h>
#import "PathSegment.h"
#import "player.h"

typedef NS_ENUM(NSInteger, MovementDirection) {
    MovementDirectionMain,
    MovementDirectionSide
};

@interface GameController : NSObject

@property (nonatomic, strong) PathSegment *start;
@property (nonatomic, strong) Player *player;

-(void)playerStatus;

-(void)printPath;

-(void)moveDirection:(NSString *)direction;


@end

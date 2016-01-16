//
//  GameController.m
//  AdventureGame


#import "GameController.h"
#import "PathSegmentContent.h"

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // generate game path
        
        _start = [self generatePath];
        _player = [[Player alloc] init];
    }
    return self;
}

-(PathSegment *)generatePath {
    
    PathSegment *home = [[PathSegment alloc] initWithContent:nil];
    
    PathSegment *mainBranchCursor = home; // primary
    PathSegment *sideBranchCursor = nil;
    self.player.location = self.start.mainRoad;
    
    for (int i = 0; i < 100; i++) {
        
        PathSegmentContent *randContent = [self randomContent];
        
        if (mainBranchCursor != nil) {
            // append to main branch
            mainBranchCursor.mainRoad = [[PathSegment alloc] initWithContent:randContent];
            mainBranchCursor = mainBranchCursor.mainRoad;
        }
        
        if (sideBranchCursor != nil) {
            // append to side branch
            sideBranchCursor.sideBranch = [[PathSegment alloc] initWithContent:randContent];
            sideBranchCursor = sideBranchCursor.sideBranch;
        }
        
        if (mainBranchCursor && sideBranchCursor) {
            // if we're branched right now, maybe merge.
            if (arc4random_uniform(10) < 3) {
                sideBranchCursor.mainRoad = mainBranchCursor;
                sideBranchCursor = nil;
            }
        } else {
            // if we're not branched right now, maybe split.
            if (arc4random_uniform(10) < 3) {
                sideBranchCursor = mainBranchCursor;
            }
        }
    }
    
    return home;
}


-(PathSegmentContent *)randomContent {
    int random_num = arc4random_uniform(10);
    if (random_num < 3) {
        PathSegmentContent *content = [[PathSegmentContent alloc] init];
        content.gold = YES;
        return content;
    }
    if (random_num > 3) {
        PathSegmentContent *content = [[PathSegmentContent alloc] init];
        content.creature = YES;
        return content;
    }
    return nil;
}


-(void)printPath {
    
    PathSegment *mainPath = self.start.mainRoad;
    PathSegment *sidePath = self.start.sideBranch;
    
    while (mainPath.mainRoad != NULL) {
        [self printMainPath:mainPath andSide:sidePath];
        
        printf("\n");
        mainPath = mainPath.mainRoad;
        
        if (mainPath.sideBranch) {
            sidePath = mainPath.sideBranch;
        } else if (sidePath) {
            sidePath = sidePath.sideBranch;
        }
    }
}


-(void)printMainPath:(PathSegment *)main andSide:(PathSegment *)side {
    if (!main) return;
    
    if (main.mainRoad && main.sideBranch) {
        printf("|\\");
    } else {
        if (main.mainRoad) {
            printf("|");
        }
        
        if (side) {
            if (side.sideBranch) {
                printf(" |");
            } else {
                printf("/");
            }
        }
    }
}


-(void)moveDirection:(NSString *)direction{
    self.player.location = self.start.mainRoad;
    
    bool adventureIsOngoing = YES;
    
    while (adventureIsOngoing) {
        
        if ([direction isEqual:@"main"]) {
            if (self.player.location.mainRoad == nil) {
                
                self.player.location = self.player.location.sideBranch;
                self.player.distanceTravelled = self.player.distanceTravelled + 1;
                if(self.player.location.content.gold) {
                    self.player.wealth = self.player.wealth + 10;
                }
                if(self.player.location.content.creature) {
                    self.player.health = self.player.health - 5;
                }
            }
            else {
                self.player.location = self.player.location.mainRoad;
                self.player.distanceTravelled = self.player.distanceTravelled + 1;
                if(self.player.location.content.gold) {
                    self.player.wealth = self.player.wealth + 10;
                }
                if(self.player.location.content.creature) {
                    self.player.health = self.player.health - 5;
                }
            }
        }
        if ([direction isEqual:@"side"]) {
            if (self.player.location.sideBranch == nil){
                self.player.location = self.player.location.mainRoad;
                self.player.distanceTravelled = self.player.distanceTravelled + 1;
                if(self.player.location.content.gold) {
                    self.player.wealth = self.player.wealth + 10;
                }
                if(self.player.location.content.creature) {
                    self.player.health = self.player.health - 5;
                }
            }
            else{
                self.player.location = self.player.location.sideBranch;
                self.player.distanceTravelled = self.player.distanceTravelled + 1;
                if(self.player.location.content.gold) {
                    self.player.wealth = self.player.wealth + 10;
                }
                if(self.player.location.content.creature) {
                    self.player.health = self.player.health - 5;
                }
            }
        }
        if (self.player.wealth < 100 && self.player.health > 0) {
            [self playerStatus];
            NSLog(@"Move by typing main or side");
            char pathChoice[255];
            fgets(pathChoice, 255, stdin);
            NSString *choice = [NSString stringWithUTF8String:pathChoice];
            direction = [choice stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        }
        else if (self.player.wealth >= 100) {
            NSLog(@"Congrats you won the game!");
            adventureIsOngoing =  NO;
            
        }
        else {
            NSLog(@"You've met an unfortunate end at the hands of a horrible monster in your quest for riches");
            adventureIsOngoing = NO;
        }
        
        
    }
}

-(void)playerStatus{
    NSLog(@"You have travelled %d",self.player.distanceTravelled);
    NSLog(@"You have %d health remaining", self.player.health);
    NSLog(@"You have accumulated %d gold", self.player.wealth);
    
    if (self.player.location.sideBranch == nil){
        NSLog(@"You can only move down the main road");
    }
    else if (self.player.location.mainRoad == nil){
        NSLog(@"You can only move down the side branch");
    }
    else {
        NSLog(@"The road splits: You can continue down the main road or venture down the side branch");
    }
}

@end
